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
      lastActive: data['lastActive'] != null
          ? DateTime.fromMillisecondsSinceEpoch((data['lastActive'] as int))
          : null,
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
    );
  }
}
