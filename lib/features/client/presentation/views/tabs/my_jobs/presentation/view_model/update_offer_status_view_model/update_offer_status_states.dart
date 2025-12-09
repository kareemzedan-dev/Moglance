class UpdateOfferStatusStates {}
class UpdateOfferStatusInitial extends UpdateOfferStatusStates {}
class UpdateOfferStatusLoadingState extends UpdateOfferStatusStates {}
class UpdateOfferStatusSuccessState extends UpdateOfferStatusStates {
 String message;
 UpdateOfferStatusSuccessState(this.message);
}
class UpdateOfferStatusErrorState extends UpdateOfferStatusStates {
  String message;
  UpdateOfferStatusErrorState(this.message);
}
