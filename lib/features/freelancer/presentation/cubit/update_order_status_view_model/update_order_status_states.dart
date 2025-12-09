class UpdateOrderStatusStates {}

class UpdateOrderStatusInitial extends UpdateOrderStatusStates {}

class UpdateOrderStatusLoading extends UpdateOrderStatusStates {}

class UpdateOrderStatusSuccess extends UpdateOrderStatusStates {
  final String message;
  UpdateOrderStatusSuccess(this.message);
}

class UpdateOrderStatusError extends UpdateOrderStatusStates {
  final String message;
  UpdateOrderStatusError(this.message);
}