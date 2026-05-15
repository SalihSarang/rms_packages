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
  final DateTime? lastActive;

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

  /// The monetary rate for the staff member's wage.
  final double? baseWage;

  /// The type of wage calculation (e.g., hourly, monthly).
  final WageType? wageType;

  /// The timestamp of the last successful salary payout.
  final DateTime? lastPaidDate;

  /// Encrypted or tokenized bank account/UPI details for payouts.
  final Map<String, dynamic>? bankDetails;

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
    this.baseWage,
    this.wageType,
    this.lastPaidDate,
    this.bankDetails,
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
      baseWage: (data['baseWage'] as num?)?.toDouble(),
      wageType: data['wageType'] != null
          ? WageType.values.firstWhere(
              (e) => e.name == data['wageType'],
              orElse: () => WageType.hourly,
            )
          : null,
      lastPaidDate: _readDate(data['lastPaidDate']),
      bankDetails: data['bankDetails'] as Map<String, dynamic>?,
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
      if (baseWage != null) 'baseWage': baseWage,
      if (wageType != null) 'wageType': wageType!.name,
      if (lastPaidDate != null)
        'lastPaidDate': lastPaidDate!.millisecondsSinceEpoch,
      if (bankDetails != null) 'bankDetails': bankDetails,
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
    double? baseWage,
    WageType? wageType,
    DateTime? lastPaidDate,
    Map<String, dynamic>? bankDetails,
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
      baseWage: baseWage ?? this.baseWage,
      wageType: wageType ?? this.wageType,
      lastPaidDate: lastPaidDate ?? this.lastPaidDate,
      bankDetails: bankDetails ?? this.bankDetails,
    );
  }

  static DateTime? _readDate(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return null;
  }
}
