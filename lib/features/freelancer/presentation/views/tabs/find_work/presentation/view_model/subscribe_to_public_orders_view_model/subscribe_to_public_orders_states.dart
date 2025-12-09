import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';

class SubscribeToPublicOrdersStates {}

class SubscribeToPublicOrdersStatesInitial extends SubscribeToPublicOrdersStates {}

class SubscribeToPublicOrdersStatesLoading extends SubscribeToPublicOrdersStates {}

class SubscribeToPublicOrdersStatesError extends SubscribeToPublicOrdersStates {
  String message;
  SubscribeToPublicOrdersStatesError({required this.message});
}

class SubscribeToPublicOrdersStatesSuccess extends SubscribeToPublicOrdersStates {
  List<OrderEntity> orders;
  SubscribeToPublicOrdersStatesSuccess({required this.orders});
}
