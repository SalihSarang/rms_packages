class AddOnsModel {
  /// The name of the add-on.
  final String name;

  /// The price of the add-on.
  final double price;

  /// The quantity of the add-on.
  final int? count;

  /// The unit of measurement for the add-on.
  final String? unit;

  AddOnsModel({required this.name, required this.price, this.count, this.unit});

  factory AddOnsModel.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return AddOnsModel(name: json?.toString() ?? 'Default', price: 0.0);
    }
    return AddOnsModel(
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      count: json['count'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      if (count != null) 'count': count,
      if (unit != null) 'unit': unit,
    };
  }
}
