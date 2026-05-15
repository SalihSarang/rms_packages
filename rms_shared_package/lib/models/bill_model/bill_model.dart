import 'package:rms_shared_package/rms_shared_package.dart';

/// Represents a finalized bill for an order.
///
/// This model combines order details with restaurant information and tax breakdowns
/// to provide a complete record of a transaction.
class BillModel {
  /// Unique identifier for the bill (Invoice Number).
  final String billId;

  /// Reference to the original order ID.
  final String orderId;

  /// Details of the restaurant at the time the bill was generated.
  final RestaurantModel restaurantInfo;

  /// Table number associated with the bill.
  final String tableNumber;

  /// Name of the staff member who served the order.
  final String staffName;

  /// Date and time when the bill was generated.
  final DateTime billDate;

  /// List of items included in the bill.
  final List<CartItemModel> items;

  /// Sum of prices of all items before taxes and other charges.
  final double subTotal;

  /// Central Goods and Services Tax amount.
  final double cgst;

  /// State Goods and Services Tax amount.
  final double sgst;

  /// Optional service charge applied to the bill.
  final double serviceCharge;

  /// Total discount amount applied.
  final double discount;

  /// The final amount to be paid by the customer.
  final double grandTotal;

  /// Method used for payment.
  final PaymentMethod? paymentMethod;

  /// Status of the payment.
  final PaymentStatus paymentStatus;

  BillModel({
    required this.billId,
    required this.orderId,
    required this.restaurantInfo,
    required this.tableNumber,
    required this.staffName,
    required this.billDate,
    required this.items,
    required this.subTotal,
    required this.cgst,
    required this.sgst,
    this.serviceCharge = 0.0,
    this.discount = 0.0,
    required this.grandTotal,
    this.paymentMethod,
    required this.paymentStatus,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      billId: json['billId'] ?? '',
      orderId: json['orderId'] ?? '',
      restaurantInfo: RestaurantModel.fromJson(json['restaurantInfo'] ?? {}),
      tableNumber: json['tableNumber'] ?? '',
      staffName: json['staffName'] ?? '',
      billDate: _parseDateTime(json['billDate']),
      items:
          (json['items'] as List?)
              ?.map((item) => CartItemModel.fromJson(item))
              .toList() ??
          [],
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0.0,
      cgst: (json['cgst'] as num?)?.toDouble() ?? 0.0,
      sgst: (json['sgst'] as num?)?.toDouble() ?? 0.0,
      serviceCharge: (json['serviceCharge'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      grandTotal: (json['grandTotal'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] != null
          ? PaymentMethod.values.byName(json['paymentMethod'])
          : null,
      paymentStatus: json['paymentStatus'] != null
          ? PaymentStatus.values.byName(json['paymentStatus'])
          : PaymentStatus.pending,
    );
  }

  static DateTime _parseDateTime(dynamic date) {
    if (date == null) return DateTime.now();
    if (date is DateTime) return date;
    if (date is String) return DateTime.tryParse(date) ?? DateTime.now();
    return DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'billId': billId,
      'orderId': orderId,
      'restaurantInfo': restaurantInfo.toJson(),
      'tableNumber': tableNumber,
      'staffName': staffName,
      'billDate': billDate.toIso8601String(),
      'items': items.map((e) => e.toJson()).toList(),
      'subTotal': subTotal,
      'cgst': cgst,
      'sgst': sgst,
      'serviceCharge': serviceCharge,
      'discount': discount,
      'grandTotal': grandTotal,
      'paymentMethod': paymentMethod?.name,
      'paymentStatus': paymentStatus.name,
    };
  }

  /// Helper to create a BillModel from an OrderModel and RestaurantModel.
  factory BillModel.fromOrder({
    required String billId,
    required OrderModel order,
    required RestaurantModel restaurant,
    double serviceCharge = 0.0,
    double discount = 0.0,
  }) {
    final subTotal = order.totalAmount;
    final cgst = subTotal * (restaurant.cgstRate / 100);
    final sgst = subTotal * (restaurant.sgstRate / 100);
    final grandTotal = subTotal + cgst + sgst + serviceCharge - discount;

    return BillModel(
      billId: billId,
      orderId: order.id,
      restaurantInfo: restaurant,
      tableNumber: order.tableNumber,
      staffName: order.staffName,
      billDate: DateTime.now(),
      items: order.orderedMenu,
      subTotal: subTotal,
      cgst: cgst,
      sgst: sgst,
      serviceCharge: serviceCharge,
      discount: discount,
      grandTotal: grandTotal,
      paymentMethod: order.paymentMethod,
      paymentStatus: order.paymentStatus,
    );
  }
}
