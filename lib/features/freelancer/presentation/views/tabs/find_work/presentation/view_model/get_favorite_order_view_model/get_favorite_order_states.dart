import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';

class GetFavoriteOrderStates {}

class GetFavoriteOrderInitial extends GetFavoriteOrderStates {}

class GetFavoriteOrderLoadingState extends GetFavoriteOrderStates {}

class GetFavoriteOrderSuccessState extends GetFavoriteOrderStates {
  final List<FavoriteOrderEntity> favoriteOrders;
  GetFavoriteOrderSuccessState(this.favoriteOrders);
}

class GetFavoriteOrderErrorState extends GetFavoriteOrderStates {
  final Failures failure;
  GetFavoriteOrderErrorState(this.failure);
}