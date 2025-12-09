import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class OrderStatusState {}

class OrderStatusInitial extends OrderStatusState {}

class OrderStatusUpdated extends OrderStatusState {
  final OrderEntity order;
  OrderStatusUpdated(this.order);
}

class OrderStatusError extends OrderStatusState {
  final String message;
  OrderStatusError(this.message);
}