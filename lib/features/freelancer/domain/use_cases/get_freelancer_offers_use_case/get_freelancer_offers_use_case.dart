import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/offer_entity/offer_entity.dart';
import '../../repos/offer_repository/offer_repository.dart';
@injectable
class GetFreelancerOffersUseCase {

  final OfferRepository  offerRepository;

  const GetFreelancerOffersUseCase({required this.offerRepository});
  Future<Either<Failures, List<OfferEntity>>> call(String freelancerId, String status) => offerRepository.getFreelancerOffers(freelancerId,status);
    Stream<(OfferEntity, String)> subscribeToOffers(
      String freelancerId,
 
  ) => offerRepository.subscribeToOffers(freelancerId);
  


}