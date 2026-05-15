import 'package:rms_shared_package/enums/enums.dart';

/// Represents a salary payout transaction to a staff member.
class PayoutModel {
  /// Unique identifier for the payout record.
  final String id;

  /// The ID of the staff member receiving the payout.
  final String staffId;

  /// The amount disbursed.
  final double amount;

  /// The currency of the payout (e.g., INR).
  final String currency;

  /// The transaction ID from the payment gateway (e.g., RazorpayX).
  final String? gatewayTransactionId;

  /// The method of payment used.
  final PaymentMethod paymentMethod;

  /// Optional notes for the payout.
  final String? notes;

  /// The current status of the payout.
  final PayoutStatus status;

  /// When the payout was initiated.
  final DateTime timestamp;

  /// The start date of the period this payout covers.
  final DateTime periodStart;

  /// The end date of the period this payout covers.
  final DateTime periodEnd;

  PayoutModel({
    required this.id,
    required this.staffId,
    required this.amount,
    this.currency = 'INR',
    this.gatewayTransactionId,
    required this.paymentMethod,
    this.notes,
    required this.status,
    required this.timestamp,
    required this.periodStart,
    required this.periodEnd,
  });

  factory PayoutModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PayoutModel(
      id: documentId,
      staffId: data['staffId'] ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      currency: data['currency'] ?? 'INR',
      gatewayTransactionId: data['gatewayTransactionId'] as String?,
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == data['paymentMethod'],
        orElse: () => PaymentMethod.cash,
      ),
      notes: data['notes'] as String?,
      status: PayoutStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => PayoutStatus.pending,
      ),
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0),
      periodStart: DateTime.fromMillisecondsSinceEpoch(
        data['periodStart'] ?? 0,
      ),
      periodEnd: DateTime.fromMillisecondsSinceEpoch(data['periodEnd'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'staffId': staffId,
      'amount': amount,
      'currency': currency,
      if (gatewayTransactionId != null)
        'gatewayTransactionId': gatewayTransactionId,
      'paymentMethod': paymentMethod.name,
      if (notes != null) 'notes': notes,
      'status': status.name,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'periodStart': periodStart.millisecondsSinceEpoch,
      'periodEnd': periodEnd.millisecondsSinceEpoch,
    };
  }

  PayoutModel copyWith({
    String? id,
    String? staffId,
    double? amount,
    String? currency,
    String? gatewayTransactionId,
    PaymentMethod? paymentMethod,
    String? notes,
    PayoutStatus? status,
    DateTime? timestamp,
    DateTime? periodStart,
    DateTime? periodEnd,
  }) {
    return PayoutModel(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      gatewayTransactionId: gatewayTransactionId ?? this.gatewayTransactionId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
    );
  }
}
