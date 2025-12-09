import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

class GetOrderViewModelStates {}
class GetOrderViewModelStatesInitial extends GetOrderViewModelStates{}
class GetOrderViewModelStatesLoading extends GetOrderViewModelStates{}
class GetOrderViewModelStatesSuccess extends GetOrderViewModelStates{
  final  List<OrderEntity> orderEntity;
  GetOrderViewModelStatesSuccess(this.orderEntity);
}
class GetOrderViewModelStatesError extends GetOrderViewModelStates{
  final String message;
  GetOrderViewModelStatesError(this.message);
}
class GetOrderViewModelStatesOrderUpdated extends GetOrderViewModelStates{
  final OrderEntity order;
  GetOrderViewModelStatesOrderUpdated(this.order);
}
class GetOrderViewModelStatesOrderDeleted extends GetOrderViewModelStates{
  final String orderId;
  GetOrderViewModelStatesOrderDeleted(this.orderId);
}
class GetOrderViewModelStatesOrderInserted extends GetOrderViewModelStates{
  final OrderEntity order;
  GetOrderViewModelStatesOrderInserted(this.order);

}