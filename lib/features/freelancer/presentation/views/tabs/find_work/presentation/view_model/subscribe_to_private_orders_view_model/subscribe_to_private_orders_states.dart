import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';

class SubscribeToPrivateOrdersStates {}

class SubscribeToPrivateOrdersStatesInitial extends SubscribeToPrivateOrdersStates {}

class SubscribeToPrivateOrdersStatesLoading extends SubscribeToPrivateOrdersStates {}

class SubscribeToPrivateOrdersStatesError extends SubscribeToPrivateOrdersStates {
  final String message;
  SubscribeToPrivateOrdersStatesError({required this.message});
}
class SubscribeToPrivateOrdersStatesSuccess extends SubscribeToPrivateOrdersStates {
  final List<OrderEntity> orders;
  SubscribeToPrivateOrdersStatesSuccess({required this.orders});
}
