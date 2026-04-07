import 'package:rms_shared_package/rms_shared_package.dart';

class CartItemModel {
  final String foodId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;
  final PortionAndPrice? selectedPortion;
  final List<AddOnsModel> selectedAddOns;
  final String? specialInstructions;

  CartItemModel({
    required this.foodId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    this.selectedPortion,
    required this.selectedAddOns,
    this.specialInstructions,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      foodId: json['foodId'],
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      selectedPortion: json['selectedPortion'] != null
          ? PortionAndPrice.fromJson(json['selectedPortion'])
          : null,
      selectedAddOns:
          (json['selectedAddOns'] as List?)
              ?.map((item) => AddOnsModel.fromJson(item))
              .toList() ??
          [],
      specialInstructions: json['specialInstructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'name': name,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'selectedPortion': selectedPortion?.toJson(),
      'selectedAddOns': selectedAddOns.map((e) => e.toJson()).toList(),
      'specialInstructions': specialInstructions,
    };
  }

  Map<String, dynamic> toKitchenJson() {
    return {
      'foodId': foodId,
      'name': name,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'selectedPortion': selectedPortion?.name,
      'selectedAddOns': selectedAddOns.map((e) => e.name).toList(),
      'specialInstructions': specialInstructions,
    };
  }
}
