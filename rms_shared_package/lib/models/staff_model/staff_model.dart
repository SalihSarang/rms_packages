import 'package:rms_shared_package/enums/enums.dart';

/// Represents a staff member working at the restaurant.
///
/// This model holds all relevant information about a staff member,
/// including their role, contact details, and status.
class StaffModel {
  /// Unique identifier for the staff member.
  final String id;

  /// The full name of the staff member.
  final String name;

  /// The email address of the staff member.
  final String email;

  /// The phone number of the staff member.
  final String phoneNumber;

  /// The role of the staff member (e.g., waiter, chef).
  final UserRole role;

  /// The URL of the staff member's avatar image.
  final String avatar;

  /// The URL of the staff member's ID proof image.
  final String idProof;

  /// Flag to indicate if the staff member is currently active.
  final bool isActive;

  /// The last time the staff member was active.
  final DateTime? lastActive;

  /// The current shift status stored as a lightweight snapshot on the staff doc.
  final ShiftStatus shiftStatus;

  /// The active shift session id, if the staff member currently has one.
  final String? currentShiftSessionId;

  /// The current shift start time, if a shift is active or paused.
  final DateTime? currentShiftStart;

  /// The most recent shift end time.
  final DateTime? currentShiftEnd;

  /// The assigned scheduled shift start time for the active day.
  final DateTime? scheduledShiftStart;

  /// The assigned scheduled shift end time for the active day.
  final DateTime? scheduledShiftEnd;

  StaffModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.avatar,
    required this.idProof,
    required this.role,
    required this.isActive,
    this.lastActive,
    this.shiftStatus = ShiftStatus.notStarted,
    this.currentShiftSessionId,
    this.currentShiftStart,
    this.currentShiftEnd,
    this.scheduledShiftStart,
    this.scheduledShiftEnd,
  });

  factory StaffModel.fromMap(Map<String, dynamic> data, String documentId) {
    return StaffModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      avatar: data['avatar'] ?? '',
      idProof: data['idProof'] ?? '',
      isActive: data['isActive'] ?? true,
      role: UserRole.values.firstWhere(
        (e) => e.name == data['role'],
        orElse: () => UserRole.waiter,
      ),
      lastActive: _readDate(data['lastActive']),
      shiftStatus: ShiftStatus.values.firstWhere(
        (e) => e.name == data['shiftStatus'],
        orElse: () => ShiftStatus.notStarted,
      ),
      currentShiftSessionId: data['currentShiftSessionId'] as String?,
      currentShiftStart: _readDate(data['currentShiftStart']),
      currentShiftEnd: _readDate(data['currentShiftEnd']),
      scheduledShiftStart: _readDate(data['scheduledShiftStart']),
      scheduledShiftEnd: _readDate(data['scheduledShiftEnd']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'idProof': idProof,
      'role': role.name,
      'isActive': isActive,
      'shiftStatus': shiftStatus.name,
      'currentShiftSessionId': currentShiftSessionId,
      if (currentShiftStart != null)
        'currentShiftStart': currentShiftStart!.millisecondsSinceEpoch,
      if (currentShiftEnd != null)
        'currentShiftEnd': currentShiftEnd!.millisecondsSinceEpoch,
      if (scheduledShiftStart != null)
        'scheduledShiftStart': scheduledShiftStart!.millisecondsSinceEpoch,
      if (scheduledShiftEnd != null)
        'scheduledShiftEnd': scheduledShiftEnd!.millisecondsSinceEpoch,
      if (lastActive != null) 'lastActive': lastActive!.millisecondsSinceEpoch,
    };
  }

  StaffModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    UserRole? role,
    String? avatar,
    String? idProof,
    bool? isActive,
    DateTime? lastActive,
    ShiftStatus? shiftStatus,
    String? currentShiftSessionId,
    DateTime? currentShiftStart,
    DateTime? currentShiftEnd,
    DateTime? scheduledShiftStart,
    DateTime? scheduledShiftEnd,
  }) {
    return StaffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      idProof: idProof ?? this.idProof,
      isActive: isActive ?? this.isActive,
      lastActive: lastActive ?? this.lastActive,
      shiftStatus: shiftStatus ?? this.shiftStatus,
      currentShiftSessionId:
          currentShiftSessionId ?? this.currentShiftSessionId,
      currentShiftStart: currentShiftStart ?? this.currentShiftStart,
      currentShiftEnd: currentShiftEnd ?? this.currentShiftEnd,
      scheduledShiftStart: scheduledShiftStart ?? this.scheduledShiftStart,
      scheduledShiftEnd: scheduledShiftEnd ?? this.scheduledShiftEnd,
    );
  }

  static DateTime? _readDate(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return null;
  }
}
