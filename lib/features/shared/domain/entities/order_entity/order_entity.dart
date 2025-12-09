import '../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../../attachments/data/models/attachments_dm/attachments_dm.dart';

class OrderEntity {
  final String id;
  final String clientId;
  final String? freelancerId;
  final String title;
  final String? description;
  final String? category;
  final List<AttachmentModel> attachments;
  final ServiceType serviceType;
  final double? budget;
  final OrderStatus status;
  final DateTime? deadline;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? offersCount;
  final String? offerId;
  final String ? lastMessage;
  final DateTime ? lastMessageTime;

  OrderEntity({
    required this.id,
    required this.clientId,
    this.freelancerId,
    required this.title,
    this.description,
    required this.category,
    this.attachments = const [],
    this.serviceType = ServiceType.public,
    this.budget,
    this.status = OrderStatus.Pending,
    this.deadline,
    required this.createdAt,
    required this.updatedAt,
    required this.offersCount,
    required this.offerId,
    this.lastMessage,
    this.lastMessageTime,
  });

  // ✅ copyWith
  OrderEntity copyWith({
    String? id,
    String? clientId,
    String? freelancerId,
    String? title,
    String? description,
    String? category,
    List<AttachmentModel>? attachments,
    ServiceType? serviceType,
    double? budget,
    OrderStatus? status,
    DateTime? deadline,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? offersCount,
    String? offerId,
    String ? lastMessage,
    DateTime ? lastMessageTime,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      freelancerId: freelancerId ?? this.freelancerId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      attachments: attachments ?? this.attachments,
      serviceType: serviceType ?? this.serviceType,
      budget: budget ?? this.budget,
      status: status ?? this.status,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      offersCount: offersCount ?? this.offersCount,
      offerId: offerId ?? this.offerId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OrderEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              status == other.status &&
              updatedAt == other.updatedAt;

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ updatedAt.hashCode;
}


enum ServiceType { public, private }

enum OrderStatus { Pending, Paid ,Accepted, InProgress,Waiting,Completed,  Cancelled }

