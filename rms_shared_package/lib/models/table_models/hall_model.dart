import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HallModel extends Equatable {
  final String id;
  final String name;
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
    return {
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  HallModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return HallModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt];
}
