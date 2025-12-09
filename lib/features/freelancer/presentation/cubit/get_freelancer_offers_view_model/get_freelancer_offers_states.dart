import '../../../domain/entities/offer_entity/offer_entity.dart';

class GetFreelancerOffersStates {}
class GetFreelancerOffersLoadingState extends GetFreelancerOffersStates {}
class GetFreelancerOffersSuccessState extends GetFreelancerOffersStates {
  final List<OfferEntity> offers;
  GetFreelancerOffersSuccessState(this.offers);
}
class GetFreelancerOffersErrorState extends GetFreelancerOffersStates {
  final String message;
  GetFreelancerOffersErrorState(this.message);
}