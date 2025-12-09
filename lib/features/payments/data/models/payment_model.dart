import 'package:taskly/features/attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../domain/entities/payment_entity.dart';


class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.id,
    super.clientId,
    super.freelancerId,
    super.orderId,
    required super.attachments,
    required super.amount,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.paymentMethod,
    super.accountNumber,
    super.requesterType,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    final attachments = json['attachments'] != null
        ? (json['attachments'] as List)
        .map((a) => AttachmentModel.fromJson(a))
        .toList()
        : <AttachmentModel>[];

    return PaymentModel(
      id: json['id'] as String,
      clientId: json['client_id'] as String?,
      freelancerId: json['freelancer_id'] as String?,
      orderId: json['order_id'] as String?,
      attachments: attachments,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      paymentMethod: json['payment_method'] as String?,
      accountNumber: json['account_number'] as String?,
      requesterType: json['requester_type'] as String?,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'freelancer_id': freelancerId,
      'order_id': orderId,
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'amount': amount,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'payment_method': paymentMethod,
      'account_number': accountNumber,
      'requester_type': requesterType,
    };
  }
}
