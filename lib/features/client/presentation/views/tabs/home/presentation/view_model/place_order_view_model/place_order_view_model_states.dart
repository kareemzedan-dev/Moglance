
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

class PlaceOrderViewModelStates {}

class PlaceOrderViewModelStatesInitial extends PlaceOrderViewModelStates {}

class PlaceOrderViewModelStatesLoading extends PlaceOrderViewModelStates {}

class PlaceOrderViewModelStatesError extends PlaceOrderViewModelStates {
  final String message;

  PlaceOrderViewModelStatesError(this.message);
}

class PlaceOrderViewModelStatesSuccess extends PlaceOrderViewModelStates {
  final OrderEntity orderEntity;

  PlaceOrderViewModelStatesSuccess(this.orderEntity);
}

class PlaceOrderViewModelFreelancerSelected extends PlaceOrderViewModelStates {
  final String id;
  PlaceOrderViewModelFreelancerSelected(this.id);
}

class PlaceOrderViewModelHiringMethodChanged extends PlaceOrderViewModelStates {
  final int index;
  PlaceOrderViewModelHiringMethodChanged(this.index);
}

