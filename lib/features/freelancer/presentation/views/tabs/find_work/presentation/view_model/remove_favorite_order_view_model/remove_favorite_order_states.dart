import '../../../../../../../../../core/errors/failures.dart';

class RemoveFavoriteOrderStates {}

class RemoveFavoriteOrderInitial extends RemoveFavoriteOrderStates {}

class RemoveFavoriteOrderLoadingState extends RemoveFavoriteOrderStates {}

class RemoveFavoriteOrderSuccessState extends RemoveFavoriteOrderStates {}

class RemoveFavoriteOrderErrorState extends RemoveFavoriteOrderStates {
  final Failures failure;
  RemoveFavoriteOrderErrorState(this.failure);
}