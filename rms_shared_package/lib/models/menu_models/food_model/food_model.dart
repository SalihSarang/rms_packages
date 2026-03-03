import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

class FoodModel {
  final String? id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isAvailable;
  final bool isFeatured;
  final bool isVeg;
  final bool isCustomNotes;
  final CategoryModel category;
  final List<PortionAndPrice> portions;
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
