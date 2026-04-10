import 'package:rms_shared_package/rms_shared_package.dart';

/// Represents a single menu item added to the cart.
///
/// This model holds detailed information about a menu item, including its
/// price, selected portion, add-ons, and special instructions.
class CartItemModel {
  /// The unique identifier of the food item.
  final String foodId;

  /// The name of the food item.
  final String name;

  /// The URL of the food item's image.
  final String imageUrl;

  /// The quantity of this item being ordered.
  final int quantity;

  /// The base price of the food item.
  final double price;

  /// The selected portion size and its corresponding price.
  final PortionAndPrice? selectedPortion;

  /// The list of add-ons selected for this menu item.
  final List<AddOnsModel> selectedAddOns;

  /// Any special instructions or modifications for this item.
  final String? specialInstructions;

  /// Flag to indicate if this item has been sent to the kitchen.
  final bool isSentToKitchen;

  /// Flag to indicate if this item has been prepared by the chef.
  final bool isPrepared;

  CartItemModel({
    required this.foodId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    this.selectedPortion,
    required this.selectedAddOns,
    this.specialInstructions,
    this.isSentToKitchen = false,
    this.isPrepared = false,
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
      isSentToKitchen: json['isSentToKitchen'] ?? false,
      isPrepared: json['isPrepared'] ?? false,
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
      'isSentToKitchen': isSentToKitchen,
      'isPrepared': isPrepared,
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
      'isSentToKitchen': isSentToKitchen,
      'isPrepared': isPrepared,
    };
  }
}
