/// Represents a category of menu items.
///
/// Categories are used to group related menu items together.
class CategoryModel {
  /// Unique identifier for the category.
  final String id;

  /// The name of the category.
  final String name;

  /// The order in which the category should be displayed.
  final int sortOrder;

  /// Flag to indicate if the category is currently active.
  final bool isActive;
  /// The number of items in the category.
  final int itemCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
    this.itemCount = 0,
  });

  factory CategoryModel.empty() {
    return CategoryModel(
      id: '',
      name: '',
      sortOrder: 0,
      isActive: true,
      itemCount: 0,
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      sortOrder: map['sortOrder'] ?? 0,
      isActive: map['isActive'] ?? true,
      itemCount: map['itemCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sortOrder': sortOrder,
      'isActive': isActive,
      'itemCount': itemCount,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    int? sortOrder,
    bool? isActive,
    int? itemCount,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
