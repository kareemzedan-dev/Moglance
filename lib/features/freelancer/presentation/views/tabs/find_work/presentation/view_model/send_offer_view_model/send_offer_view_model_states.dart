class SendOfferViewModelStates {}

class SendOfferViewModelInitial extends SendOfferViewModelStates {}

class SendOfferViewModelLoading extends SendOfferViewModelStates {}

class SendOfferViewModelError extends SendOfferViewModelStates {
  String errorMessage;
  SendOfferViewModelError({required this.errorMessage});
}

class SendOfferViewModelSuccess extends SendOfferViewModelStates {
  String message;
  SendOfferViewModelSuccess({required this.message});
}