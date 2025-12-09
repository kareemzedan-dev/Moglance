import 'package:taskly/features/attachments/data/models/attachments_dm/attachments_dm.dart';
class PaymentEntity {
  final String id;
  final String? clientId;
  final String? freelancerId;
  final String? orderId;
  final List<AttachmentModel> attachments;
  final double amount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? paymentMethod;
  final String? accountNumber;
  final String? requesterType;

  PaymentEntity({
    required this.id,
    this.clientId,
    this.freelancerId,
    this.orderId,
    required this.attachments,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.paymentMethod,
    this.accountNumber,
    this.requesterType,
  });
  factory PaymentEntity.forFreelancer({
    required String id,
    required double amount,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? freelancerId,
    String? paymentMethod,
    String? accountNumber,
  }) {
    return PaymentEntity(
      id: id,
      freelancerId: freelancerId,
      amount: amount,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      paymentMethod: paymentMethod,
      accountNumber: accountNumber,
      attachments: [],
    );
  }
}