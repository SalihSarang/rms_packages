import '../../enums/enums.dart';
import 'pause_entry.dart';

class ShiftSession {
  final String id;
  final String staffId;
  final UserRole role;
  final String dateKey;
  final DateTime? scheduledStart;
  final DateTime? scheduledEnd;
  final DateTime? actualStart;
  final DateTime? actualEnd;
  final List<PauseEntry> pauseEntries;
  final int workedMinutes;
  final ShiftStatus status;
  final bool isPaid;
  final String? payoutId;

  const ShiftSession({
    required this.id,
    required this.staffId,
    required this.role,
    required this.dateKey,
    required this.scheduledStart,
    required this.scheduledEnd,
    required this.actualStart,
    required this.actualEnd,
    required this.pauseEntries,
    required this.workedMinutes,
    required this.status,
    this.isPaid = false,
    this.payoutId,
  });

  factory ShiftSession.fromMap(Map<String, dynamic> map, String id) {
    return ShiftSession(
      id: id,
      staffId: map['staffId'] as String? ?? '',
      role: UserRole.values.firstWhere(
        (value) => value.name == map['role'],
        orElse: () => UserRole.waiter,
      ),
      dateKey: map['dateKey'] as String? ?? '',
      scheduledStart: _readDate(map['scheduledStart']),
      scheduledEnd: _readDate(map['scheduledEnd']),
      actualStart: _readDate(map['actualStart']),
      actualEnd: _readDate(map['actualEnd']),
      pauseEntries: ((map['pauseEntries'] as List?) ?? const <dynamic>[])
          .whereType<Map<String, dynamic>>()
          .map(PauseEntry.fromMap)
          .toList(),
      workedMinutes: (map['workedMinutes'] as num?)?.toInt() ?? 0,
      status: ShiftStatus.values.firstWhere(
        (value) => value.name == map['status'],
        orElse: () => ShiftStatus.notStarted,
      ),
      isPaid: map['isPaid'] as bool? ?? false,
      payoutId: map['payoutId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'staffId': staffId,
      'role': role.name,
      'dateKey': dateKey,
      'scheduledStart': scheduledStart?.millisecondsSinceEpoch,
      'scheduledEnd': scheduledEnd?.millisecondsSinceEpoch,
      'actualStart': actualStart?.millisecondsSinceEpoch,
      'actualEnd': actualEnd?.millisecondsSinceEpoch,
      'pauseEntries': pauseEntries.map((entry) => entry.toMap()).toList(),
      'workedMinutes': workedMinutes,
      'status': status.name,
      'isPaid': isPaid,
      if (payoutId != null) 'payoutId': payoutId,
    };
  }

  ShiftSession copyWith({
    String? id,
    String? staffId,
    UserRole? role,
    String? dateKey,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? actualStart,
    DateTime? actualEnd,
    List<PauseEntry>? pauseEntries,
    int? workedMinutes,
    ShiftStatus? status,
    bool? isPaid,
    String? payoutId,
  }) {
    return ShiftSession(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      role: role ?? this.role,
      dateKey: dateKey ?? this.dateKey,
      scheduledStart: scheduledStart ?? this.scheduledStart,
      scheduledEnd: scheduledEnd ?? this.scheduledEnd,
      actualStart: actualStart ?? this.actualStart,
      actualEnd: actualEnd ?? this.actualEnd,
      pauseEntries: pauseEntries ?? this.pauseEntries,
      workedMinutes: workedMinutes ?? this.workedMinutes,
      status: status ?? this.status,
      isPaid: isPaid ?? this.isPaid,
      payoutId: payoutId ?? this.payoutId,
    );
  }

  static DateTime? _readDate(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return null;
  }
}
