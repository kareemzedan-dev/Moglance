import '../../../profile/domain/entities/user_info_entity/user_info_entity.dart';
import '../../../shared/domain/entities/order_entity/order_entity.dart';

class ConversationEntity {
  final UserInfoEntity user;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final OrderEntity? order;
  final String? orderId;

  ConversationEntity({
    required this.user,
    this.lastMessage,
    this.lastMessageTime,
    this.order,
    this.orderId,
  });
}
