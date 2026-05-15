import 'package:rms_shared_package/enums/enums.dart';

/// Represents a table in the restaurant.
///
/// This model holds information about a table's position, size, capacity,
/// and current status.
class TableModel {
  /// Unique identifier for the table.
  final String id;

  /// The name or number of the table.
  final String name;

  /// The x-coordinate of the table's position on the floor plan.
  final double x;

  /// The y-coordinate of the table's position on the floor plan.
  final double y;

  /// The width of the table.
  final double width;

  /// The height of the table.
  final double height;

  /// The identifier of the hall this table belongs to.
  final String hallId;

  /// The maximum number of seats at the table.
  final int seats;

  /// The shape of the table (e.g., rectangle, circle).
  final TableShape shape;

  /// The current status of the table (e.g., available, occupied).
  final TableStatus status;

  /// The number of seats currently occupied.
  final int occupiedSeats;

  const TableModel({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.hallId,
    required this.seats,
    required this.shape,
    this.status = TableStatus.available,
    this.occupiedSeats = 0,
  });

  factory TableModel.fromMap(Map<String, dynamic> map, String docId) {
    return TableModel(
      id: docId,
      name: map['name'] ?? '',
      x: (map['x'] as num? ?? 0).toDouble(),
      y: (map['y'] as num? ?? 0).toDouble(),
      width: (map['width'] as num? ?? 100).toDouble(),
      height: (map['height'] as num? ?? 100).toDouble(),
      hallId: map['hallId'] ?? '',
      seats: (map['seats'] as num? ?? 4).toInt(),
      occupiedSeats: (map['occupiedSeats'] as num? ?? 0).toInt(),
      shape: TableShape.values.firstWhere(
        (e) => e.name == map['shape'],
        orElse: () => TableShape.rectangle,
      ),
      status: TableStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TableStatus.available,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'hallId': hallId,
      'seats': seats,
      'occupiedSeats': occupiedSeats,
      'shape': shape.name,
      'status': status.name,
    };
  }

  TableModel copyWith({
    String? id,
    String? name,
    double? x,
    double? y,
    double? width,
    double? height,
    String? hallId,
    int? seats,
    int? occupiedSeats,
    TableShape? shape,
    TableStatus? status,
  }) {
    return TableModel(
      id: id ?? this.id,
      name: name ?? this.name,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      hallId: hallId ?? this.hallId,
      seats: seats ?? this.seats,
      occupiedSeats: occupiedSeats ?? this.occupiedSeats,
      shape: shape ?? this.shape,
      status: status ?? this.status,
    );
  }
}
