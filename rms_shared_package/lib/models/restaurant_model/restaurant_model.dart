class RestaurantModel {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String fssaiNumber;
  final String gstin;
  final double cgstRate;
  final double sgstRate;
  final String currency;

  const RestaurantModel({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.fssaiNumber,
    required this.gstin,
    this.cgstRate = 2.5,
    this.sgstRate = 2.5,
    this.currency = 'INR',
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      fssaiNumber: json['fssaiNumber'] ?? '',
      gstin: json['gstin'] ?? '',
      cgstRate: (json['cgstRate'] ?? 2.5).toDouble(),
      sgstRate: (json['sgstRate'] ?? 2.5).toDouble(),
      currency: json['currency'] ?? 'INR',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'fssaiNumber': fssaiNumber,
      'gstin': gstin,
      'cgstRate': cgstRate,
      'sgstRate': sgstRate,
      'currency': currency,
    };
  }

  RestaurantModel copyWith({
    String? name,
    String? address,
    String? phone,
    String? email,
    String? fssaiNumber,
    String? gstin,
    double? cgstRate,
    double? sgstRate,
    String? currency,
  }) {
    return RestaurantModel(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      fssaiNumber: fssaiNumber ?? this.fssaiNumber,
      gstin: gstin ?? this.gstin,
      cgstRate: cgstRate ?? this.cgstRate,
      sgstRate: sgstRate ?? this.sgstRate,
      currency: currency ?? this.currency,
    );
  }
}
