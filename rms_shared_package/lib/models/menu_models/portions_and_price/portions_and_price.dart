class PortionAndPrice {
  final String name;
  final double price;
  final int? count;
  final String? unit;

  PortionAndPrice({
    required this.name,
    required this.price,
    this.count,
    this.unit,
  });

  factory PortionAndPrice.fromJson(Map<String, dynamic> json) {
    return PortionAndPrice(
      name: json['name'],
      price: json['price'],
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
