import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';

class GetFavouriteOrderDetailsStates {}
class GetFavouriteOrderDetailsInitial extends GetFavouriteOrderDetailsStates {}
class GetFavouriteOrderDetailsLoadingState extends GetFavouriteOrderDetailsStates {}
class GetFavouriteOrderDetailsSuccessState extends GetFavouriteOrderDetailsStates {
  final List<OrderEntity> orders;
  GetFavouriteOrderDetailsSuccessState(this.orders);
}
class GetFavouriteOrderDetailsErrorState extends GetFavouriteOrderDetailsStates {
  final String message;
  GetFavouriteOrderDetailsErrorState(this.message);
}