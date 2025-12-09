class PlaceWithdrawalBalanceStates {}

class PlaceWithdrawalBalanceInitial extends PlaceWithdrawalBalanceStates {}

class PlaceWithdrawalBalanceLoadingState extends PlaceWithdrawalBalanceStates {}

class PlaceWithdrawalBalanceSuccessState extends PlaceWithdrawalBalanceStates {}

class PlaceWithdrawalBalanceErrorState extends PlaceWithdrawalBalanceStates {
  final String message;
  PlaceWithdrawalBalanceErrorState({required this.message});
}