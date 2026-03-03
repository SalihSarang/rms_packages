enum TableStatus { available, partiallyOccupied, occupied, disabled }

enum TableShape { square, rectangle, circle }

class TableModel {
  final int id;
  final String name;
  final int capacity;
  final TableStatus status;
  final TableShape shape;
  final int currentGuests;
  final String hallId;
  final double posX;
  final double posY;

  TableModel({
    required this.id,
    required this.name,
    required this.capacity,
    required this.status,
    required this.shape,
    required this.currentGuests,
    required this.hallId,
    required this.posX,
    required this.posY,
  });

  TableModel copyWith({
    int? capacity,
    int? currentGuests,
    TableStatus? status,
    double? posX,
    double? posY,
  }) {
    return TableModel(
      id: id,
      name: name,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
      shape: shape,
      currentGuests: currentGuests ?? this.currentGuests,
      hallId: hallId,
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
    );
  }

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
      status: TableStatus.values.firstWhere((e) => e.name == json['status']),
      shape: TableShape.values.firstWhere((e) => e.name == json['shape']),
      currentGuests: json['currentGuests'],
      hallId: json['hallId'],
      posX: json['posX'],
      posY: json['posY'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
      'status': status.name,
      'shape': shape.name,
      'currentGuests': currentGuests,
      'hallId': hallId,
      'posX': posX,
      'posY': posY,
    };
  }
}
