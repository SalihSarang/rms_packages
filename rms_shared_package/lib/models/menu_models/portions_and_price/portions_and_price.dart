/// Represents a portion size and its corresponding price for a food item.
///
/// Allows specifying different sizes (e.g., Small, Medium, Large)
/// with their own prices.
class PortionAndPrice {
  /// The name of the portion (e.g., "Small", "1/2 Dozen").
  final String name;

  /// The price for this portion.
  final double price;

  /// The quantity for this portion (optional).
  final int? count;

  /// The unit of measurement for this portion (optional).
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
