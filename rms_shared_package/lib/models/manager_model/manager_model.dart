/// Represents a manager user in the system.
///
/// This model holds the credentials and basic information for a manager.
class ManagerModel {
  /// The name of the manager.
  final String name;

  /// The email address of the manager.
  final String email;

  /// The password for the manager account.
  final String password;

  const ManagerModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}
