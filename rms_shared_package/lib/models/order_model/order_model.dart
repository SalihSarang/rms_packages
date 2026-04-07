import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/order_model/ordered_menu_model.dart';

class OrderModel {
  String id;
  String tableNumber;
  String staffId;
  int seatCount;
  OrderStatus orderStatus;
  List<CartItemModel> orderedMenu;
  double totalAmount;
  PaymentMethod? paymentMethod;
  PaymentStatus paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.tableNumber,
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
      orderStatus: OrderStatus.values.byName(json['orderStatus']),
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

  Map<String, dynamic> toKitchenJson() {
    return {
      'id': id,
      'tableNumber': tableNumber,
      'orderedMenu': orderedMenu.map((e) => e.toKitchenJson()).toList(),
      'orderStatus': orderStatus.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
