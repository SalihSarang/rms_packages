import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Represents a hall or section within the restaurant.
///
/// Halls are used to organize tables and define the layout of the dining area.
class HallModel extends Equatable {
  /// Unique identifier for the hall.
  final String id;

  /// The name of the hall (e.g., "Main Hall", "Patio").
  final String name;

  /// The date and time when the hall was created.
  final DateTime createdAt;

  const HallModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory HallModel.fromMap(Map<String, dynamic> map, String docId) {
    DateTime parseDate(dynamic value) {
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      if (value is String) return DateTime.parse(value);
      if (value is Timestamp) return value.toDate();
      return DateTime.now();
    }

    return HallModel(
      id: docId,
      name: map['name'] ?? '',
      createdAt: parseDate(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'createdAt': createdAt.millisecondsSinceEpoch};
  }

  HallModel copyWith({String? id, String? name, DateTime? createdAt}) {
    return HallModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt];
}
