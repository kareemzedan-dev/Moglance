class WithdrawOfferStates {}

class WithdrawOfferStatesInitial extends WithdrawOfferStates {}

class WithdrawOfferStatesSuccess extends WithdrawOfferStates {
  final String message;
  WithdrawOfferStatesSuccess({required this.message});
}

class WithdrawOfferStatesError extends WithdrawOfferStates {
  final String message;
  WithdrawOfferStatesError({required this.message});
}

class WithdrawOfferStatesLoading extends WithdrawOfferStates {}
