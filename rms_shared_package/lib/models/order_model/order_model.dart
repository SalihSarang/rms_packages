import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/order_model/ordered_menu_model.dart';

/// Represents a customer order placed at a table.
///
/// This model holds all relevant information about an order, including
/// its status, items ordered, payment details, and timestamps.
class OrderModel {
  /// Unique identifier for the order.
  String id;

  /// The table number where the order was placed.
  String tableNumber;

  /// The unique identifier for the table document.
  String tableId;

  /// The ID of the staff member who took the order.
  String staffId;

  /// The number of seats occupied by the customers.
  int seatCount;

  /// The current status of the order (e.g., pending, preparing, ready).
  OrderStatus orderStatus;

  /// The list of menu items included in this order.
  List<CartItemModel> orderedMenu;

  /// The total cost of all items in the order.
  double totalAmount;

  /// The method used for payment (e.g., cash, card).
  PaymentMethod? paymentMethod;

  /// The status of the payment (e.g., paid, unpaid).
  PaymentStatus paymentStatus;

  /// The date and time when the order was created.
  DateTime createdAt;

  /// The date and time when the order was last updated.
  DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.tableId,
    required this.staffId,
    required this.orderedMenu,
    this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.totalAmount,
    required this.seatCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      tableNumber: json['tableNumber'] ?? '',
      tableId: json['tableId'] ?? '',
      staffId: json['staffId'] ?? '',
      orderedMenu:
          (json['orderedMenu'] as List?)
              ?.map((item) => CartItemModel.fromJson(item))
              .toList() ??
          [],
      paymentMethod: json['paymentMethod'] != null
          ? PaymentMethod.values.byName(json['paymentMethod'])
          : null,
      paymentStatus: PaymentStatus.values.byName(json['paymentStatus']),
      orderStatus: _parseOrderStatus(json['orderStatus']),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      seatCount: json['seatCount'] ?? 0,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tableNumber': tableNumber,
      'tableId': tableId,
      'staffId': staffId,
      'orderedMenu': orderedMenu.map((e) => e.toJson()).toList(),
      'paymentMethod': paymentMethod?.name,
      'paymentStatus': paymentStatus.name,
      'orderStatus': orderStatus.name,
      'totalAmount': totalAmount,
      'seatCount': seatCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Converts the order to a JSON format suitable for the kitchen display system.
  ///
  /// This method strips out payment details and other non-essential information,
  /// focusing on what the kitchen staff needs to know.
  Map<String, dynamic> toKitchenJson() {
    return {
      'id': id,
      'tableNumber': tableNumber,
      'orderedMenu': orderedMenu.map((e) => e.toKitchenJson()).toList(),
      'orderStatus': orderStatus.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static OrderStatus _parseOrderStatus(String? status) {
    if (status == null) return OrderStatus.pending;
    if (status == 'billRequested') return OrderStatus.served;
    if (status == 'checkout') return OrderStatus.completed;

    try {
      return OrderStatus.values.byName(status);
    } catch (_) {
      return OrderStatus.pending;
    }
  }
}
