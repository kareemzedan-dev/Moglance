
class AddFavoriteOrderStates {}
class AddFavoriteOrderInitial extends AddFavoriteOrderStates {}

class AddFavoriteOrderLoadingState extends AddFavoriteOrderStates {}

class AddFavoriteOrderSuccessState extends AddFavoriteOrderStates {
  final String message;
  final String orderId;   // <-- ده مهم عشان تقدر تحدد الأوردر
  AddFavoriteOrderSuccessState(this.message, this.orderId);
}
class AddFavoriteOrderErrorState extends AddFavoriteOrderStates {
  final String error;
  AddFavoriteOrderErrorState(this.error);
}
class AddFavoriteOrderRemovedState extends AddFavoriteOrderStates {
  final String orderId;
  AddFavoriteOrderRemovedState(this.orderId);
}
class AddFavoriteOrderLoadedState extends AddFavoriteOrderStates {
  final List<String> favoriteOrderIds;
  AddFavoriteOrderLoadedState(this.favoriteOrderIds);
}
