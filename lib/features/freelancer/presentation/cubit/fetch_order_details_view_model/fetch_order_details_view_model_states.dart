import '../../../../shared/domain/entities/order_entity/order_entity.dart';

class FetchOrderDetailsViewModelStates {}
class FetchOrderDetailsViewModelStatesIntial extends FetchOrderDetailsViewModelStates {}
class FetchOrderDetailsViewModelStatesLoading extends FetchOrderDetailsViewModelStates {}
class FetchOrderDetailsViewModelStatesSuccess extends FetchOrderDetailsViewModelStates {
  final OrderEntity orderEntity;
  FetchOrderDetailsViewModelStatesSuccess({required this.orderEntity});
}
class FetchOrderDetailsViewModelStatesError extends FetchOrderDetailsViewModelStates {
  final String message;
  FetchOrderDetailsViewModelStatesError({required this.message});
}