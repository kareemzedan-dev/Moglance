import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

class FreelancerPublicOrdersState {}

class FreelancerPendingOrdersInitial extends FreelancerPublicOrdersState {}

class FreelancerPendingOrdersLoading extends FreelancerPublicOrdersState {}

class FreelancerPendingOrdersError extends FreelancerPublicOrdersState {
  final String errorMessage;
  FreelancerPendingOrdersError(this.errorMessage);
}

class FreelancerPendingOrdersEmpty extends FreelancerPublicOrdersState {}

class FreelancerPendingOrdersSuccess extends FreelancerPublicOrdersState {
  final List<OrderEntity> pendingOrdersList;
  FreelancerPendingOrdersSuccess(this.pendingOrdersList);
}