import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';

import '../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class OfferRepository {
  Future<Either<Failures, OfferEntity>> placeOffer(OfferEntity offer);
  Future<Either<Failures, List<OfferEntity>>> getFreelancerOffers(String freelancerId, String status );
  Future<Either<Failures,OrderEntity>> fetchOrderDetails(String orderId );
    Stream<(OfferEntity, String)> subscribeToOffers(
      String freelancerId,
 
      );
 

}