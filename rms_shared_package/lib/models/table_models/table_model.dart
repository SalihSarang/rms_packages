import 'package:rms_shared_package/enums/enums.dart';

class TableModel {
  final String id;
  final String name;
  final double x;
  final double y;
  final double width;
  final double height;
  final String hallId;
  final int seats;
  final TableShape shape;
  final TableStatus status;

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
      shape: shape ?? this.shape,
      status: status ?? this.status,
    );
  }
}
