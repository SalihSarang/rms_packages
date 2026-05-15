import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/db_constants.dart';
import '../enums/enums.dart';
import '../models/shift_models/pause_entry.dart';
import '../models/shift_models/shift_schedule.dart';
import '../models/shift_models/shift_session.dart';
import '../models/staff_model/staff_model.dart';
import '../utils/shift_utils.dart';
import 'shift_repository.dart';

class FirestoreShiftRepository implements ShiftRepository {
  final FirebaseFirestore firestore;

  FirestoreShiftRepository({required this.firestore});

  CollectionReference<Map<String, dynamic>> _staffCollection() {
    return firestore.collection(StaffDbConstants.staff);
  }

  CollectionReference<Map<String, dynamic>> _historyCollection(String staffId) {
    return _staffCollection()
        .doc(staffId)
        .collection(StaffDbConstants.shiftHistory);
  }

  CollectionReference<Map<String, dynamic>> _scheduleCollection(
    String staffId,
  ) {
    return _staffCollection()
        .doc(staffId)
        .collection(StaffDbConstants.shiftSchedule);
  }

  @override
  Future<ShiftSchedule?> getTodayShiftSchedule(String staffId) async {
    final snapshot = await _scheduleCollection(
      staffId,
    ).where('isEnabled', isEqualTo: true).get();
    final today = DateTime.now();

    for (final doc in snapshot.docs) {
      final schedule = ShiftSchedule.fromMap(doc.data(), doc.id);
      if (schedule.appliesTo(today)) {
        return schedule;
      }
    }

    return null;
  }

  @override
  Future<ShiftSession?> getCurrentShiftSession(String staffId) async {
    final staffDoc = await _staffCollection().doc(staffId).get();
    final data = staffDoc.data();
    final currentSessionId = data?['currentShiftSessionId'] as String?;

    if (currentSessionId != null && currentSessionId.isNotEmpty) {
      final sessionDoc = await _historyCollection(
        staffId,
      ).doc(currentSessionId).get();
      if (sessionDoc.exists && sessionDoc.data() != null) {
        return ShiftSession.fromMap(sessionDoc.data()!, sessionDoc.id);
      }
    }

    final snapshot = await _historyCollection(staffId)
        .where(
          'status',
          whereIn: [ShiftStatus.active.name, ShiftStatus.paused.name],
        )
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    final doc = snapshot.docs.first;
    return ShiftSession.fromMap(doc.data(), doc.id);
  }

  @override
  Future<List<ShiftSession>> getShiftHistory(
    String staffId, {
    int limit = 10,
  }) async {
    final snapshot = await _historyCollection(
      staffId,
    ).orderBy('actualStart', descending: true).limit(limit).get();
    return snapshot.docs
        .map((doc) => ShiftSession.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<ShiftSession> startShift(StaffModel staff) async {
    final existing = await getCurrentShiftSession(staff.id);
    if (existing != null &&
        (existing.status == ShiftStatus.active ||
            existing.status == ShiftStatus.paused)) {
      throw Exception('A shift is already in progress.');
    }

    final now = DateTime.now();
    final sessionDoc = _historyCollection(staff.id).doc();
    final session = ShiftSession(
      id: sessionDoc.id,
      staffId: staff.id,
      role: staff.role,
      dateKey: ShiftUtils.dateKey(now),
      scheduledStart: null,
      scheduledEnd: null,
      actualStart: now,
      actualEnd: null,
      pauseEntries: const [],
      workedMinutes: 0,
      status: ShiftStatus.active,
    );

    final batch = firestore.batch();
    batch.set(sessionDoc, session.toMap());
    batch.update(_staffCollection().doc(staff.id), {
      'shiftStatus': ShiftStatus.active.name,
      'currentShiftSessionId': session.id,
      'currentShiftStart': now.millisecondsSinceEpoch,
      'currentShiftEnd': null,
      'scheduledShiftStart': null,
      'scheduledShiftEnd': null,
      'lastActive': now.millisecondsSinceEpoch,
    });
    await batch.commit();
    return session;
  }

  @override
  Future<ShiftSession> pauseShift(String staffId) async {
    final session = await _requireCurrentSession(staffId);
    if (session.status != ShiftStatus.active) {
      throw Exception('Only an active shift can be paused.');
    }

    final now = DateTime.now();
    final updated = session.copyWith(
      pauseEntries: [
        ...session.pauseEntries,
        PauseEntry(pausedAt: now, resumedAt: null, durationMinutes: 0),
      ],
      status: ShiftStatus.paused,
    );

    await _historyCollection(staffId).doc(session.id).update(updated.toMap());
    await _staffCollection().doc(staffId).update({
      'shiftStatus': ShiftStatus.paused.name,
      'lastActive': now.millisecondsSinceEpoch,
    });
    return updated;
  }

  @override
  Future<ShiftSession> resumeShift(String staffId) async {
    final session = await _requireCurrentSession(staffId);
    if (session.status != ShiftStatus.paused) {
      throw Exception('Only a paused shift can be resumed.');
    }

    final now = DateTime.now();
    final pauses = List<PauseEntry>.from(session.pauseEntries);
    final index = pauses.lastIndexWhere((entry) => entry.resumedAt == null);
    if (index == -1) {
      throw Exception('No paused break found to resume.');
    }
    final openPause = pauses[index];
    pauses[index] = openPause.copyWith(
      resumedAt: now,
      durationMinutes: now.difference(openPause.pausedAt).inMinutes,
    );

    final updated = session.copyWith(
      pauseEntries: pauses,
      status: ShiftStatus.active,
    );
    await _historyCollection(staffId).doc(session.id).update(updated.toMap());
    await _staffCollection().doc(staffId).update({
      'shiftStatus': ShiftStatus.active.name,
      'lastActive': now.millisecondsSinceEpoch,
    });
    return updated;
  }

  @override
  Future<ShiftSession> endShift(String staffId) async {
    final session = await _requireCurrentSession(staffId);
    if (session.status != ShiftStatus.active &&
        session.status != ShiftStatus.paused) {
      throw Exception('Only an active or paused shift can be ended.');
    }

    final now = DateTime.now();
    var pauses = List<PauseEntry>.from(session.pauseEntries);
    final index = pauses.lastIndexWhere((entry) => entry.resumedAt == null);
    if (index != -1) {
      final openPause = pauses[index];
      pauses[index] = openPause.copyWith(
        resumedAt: now,
        durationMinutes: now.difference(openPause.pausedAt).inMinutes,
      );
    }

    final workedMinutes = ShiftUtils.calculateWorkedMinutes(
      start: session.actualStart,
      end: now,
      pauseEntries: pauses,
    );
    final updated = session.copyWith(
      actualEnd: now,
      pauseEntries: pauses,
      workedMinutes: workedMinutes,
      status: ShiftStatus.ended,
    );

    final batch = firestore.batch();
    batch.update(_historyCollection(staffId).doc(session.id), updated.toMap());
    batch.update(_staffCollection().doc(staffId), {
      'shiftStatus': ShiftStatus.ended.name,
      'currentShiftSessionId': null,
      'currentShiftEnd': now.millisecondsSinceEpoch,
      'lastActive': now.millisecondsSinceEpoch,
    });
    await batch.commit();
    return updated;
  }

  @override
  Future<void> markShiftsAsPaid(
    String staffId,
    List<String> shiftIds,
    String payoutId,
  ) async {
    final batch = firestore.batch();
    final collection = _historyCollection(staffId);

    for (final id in shiftIds) {
      batch.update(collection.doc(id), {'isPaid': true, 'payoutId': payoutId});
    }

    await batch.commit();
  }

  Future<ShiftSession> _requireCurrentSession(String staffId) async {
    final session = await getCurrentShiftSession(staffId);
    if (session == null) {
      throw Exception('No active shift found.');
    }
    return session;
  }
}
