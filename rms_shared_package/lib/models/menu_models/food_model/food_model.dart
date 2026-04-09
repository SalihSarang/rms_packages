import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

/// Represents a food item on the menu.
///
/// This model holds detailed information about a menu item,
/// including its name, description, price, category, and other attributes.
class FoodModel {
  /// Unique identifier for the food item.
  final String? id;

  /// The name of the food item.
  final String name;

  /// The description of the food item.
  final String description;

  /// The URL of the food item's image.
  final String imageUrl;

  /// Flag to indicate if the food item is currently available.
  final bool isAvailable;

  /// Flag to indicate if the food item is featured.
  final bool isFeatured;

  /// Flag to indicate if the food item is vegetarian.
  final bool isVeg;

  /// Flag to indicate if the food item has custom notes.
  final bool isCustomNotes;

  /// The category of the food item.
  final CategoryModel category;

  /// The list of portions and their prices.
  final List<PortionAndPrice> portions;

  /// The list of add-ons available for this food item.
  final List<AddOnsModel> addOns;

  FoodModel({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
    required this.isFeatured,
    required this.portions,
    required this.addOns,
    required this.isVeg,
    required this.isCustomNotes,
  });

  factory FoodModel.empty() {
    return FoodModel(
      id: '',
      name: '',
      description: '',
      imageUrl: '',
      category: CategoryModel.empty(),
      isAvailable: false,
      isFeatured: false,
      portions: [],
      addOns: [],
      isVeg: false,
      isCustomNotes: false,
    );
  }

  factory FoodModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return FoodModel(
      id: docId ?? json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      category: CategoryModel.fromMap(json['category'] as Map<String, dynamic>),
      isAvailable: json['isAvailable'] as bool,
      isFeatured: json['isFeatured'] as bool,
      portions: (json['portions'] as List)
          .map((e) => PortionAndPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
      addOns: (json['addOns'] as List)
          .map((e) => AddOnsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isVeg: json['isVeg'] as bool,
      isCustomNotes: json['isCustomNotes'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'category': category.toMap(),
      'categoryId': category.id,
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'portions': portions.map((e) => e.toJson()).toList(),
      'addOns': addOns.map((e) => e.toJson()).toList(),
      'isVeg': isVeg,
      'isCustomNotes': isCustomNotes,
    };
  }
}
