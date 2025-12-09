import '../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class OrderViewModelState  {

}

class OrderInitial extends OrderViewModelState {}

class OrderLoading extends OrderViewModelState {}

class OrderSuccess extends OrderViewModelState {
  final OrderEntity order;
   OrderSuccess(this.order);

}

class OrderError extends OrderViewModelState {
  final String message;

    OrderError(this.message);

}
