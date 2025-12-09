import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/data/data_sources/remote/offer_data_source.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/freelancer/domain/repos/offer_repository/offer_repository.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
@Injectable(as:OfferRepository )
class OfferRepositoryImpl extends OfferRepository {
  OfferRemoteDataSource offerRemoteDataSource;

  OfferRepositoryImpl(this.offerRemoteDataSource);
  @override
  Future<Either<Failures, OfferEntity>> placeOffer(OfferEntity offer) {
     return offerRemoteDataSource.placeOffer(offer);
  }

  @override
  Future<Either<Failures, List<OfferEntity>>> getFreelancerOffers(String freelancerId, String status) {
 return offerRemoteDataSource.getFreelancerOffers(freelancerId, status);
  }

  @override
  Future<Either<Failures, OrderEntity>> fetchOrderDetails(String orderId) {
   return offerRemoteDataSource.fetchOrderDetails(orderId);
  }

  @override
  Stream<(OfferEntity, String)> subscribeToOffers(String freelancerId, ) {
  return offerRemoteDataSource.subscribeToOffers(freelancerId, );
  }
 

}