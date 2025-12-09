class DeleteOrderStates {}
class DeleteOrderInitial extends DeleteOrderStates {}
class DeleteOrderLoadingState extends DeleteOrderStates {}

class DeleteOrderSuccessState extends DeleteOrderStates {}

class DeleteOrderErrorState extends DeleteOrderStates {
  final String message;
  DeleteOrderErrorState(this.message);
}
