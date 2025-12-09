import '../../../../../../../../../core/errors/failures.dart';

class  IsOrderFavoriteStates {}

class  IsOrderFavoriteInitial extends IsOrderFavoriteStates {}

class  IsOrderFavoriteLoadingState extends IsOrderFavoriteStates {}

class  IsOrderFavoriteSuccessState extends IsOrderFavoriteStates {
  final bool isFavorite;
  IsOrderFavoriteSuccessState(this.isFavorite);
}

class  IsOrderFavoriteErrorState extends IsOrderFavoriteStates {
  final Failures failure;
  IsOrderFavoriteErrorState(this.failure);
}