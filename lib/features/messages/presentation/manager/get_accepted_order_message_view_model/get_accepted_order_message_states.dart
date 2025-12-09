import '../../../../shared/domain/entities/order_entity/order_entity.dart';

class  GetAcceptedOrderMessageStates {}
class GetAcceptedOrderMessageStatesInitial extends GetAcceptedOrderMessageStates {}
class GetAcceptedOrderMessageStatesLoading extends GetAcceptedOrderMessageStates {}

class GetAcceptedOrderMessageStatesSuccess extends GetAcceptedOrderMessageStates {
  final List<OrderEntity> orders;
  GetAcceptedOrderMessageStatesSuccess({required this.orders});
}

class GetAcceptedOrderMessageStatesError extends GetAcceptedOrderMessageStates {
  final String message;
  GetAcceptedOrderMessageStatesError({required this.message});
}