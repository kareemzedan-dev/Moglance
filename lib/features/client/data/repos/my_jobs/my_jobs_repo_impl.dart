import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/data/data_sources/remote/my_jobs_remote_data_source.dart';
import 'package:taskly/features/client/domain/repos/my_jobs/my_jobs_repo.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';


@Injectable(as: MyJobsRepo)
class MyJobsRepoImpl extends MyJobsRepo {
  final MyJobsRemoteDataSource myJobsRemoteDataSource;

  MyJobsRepoImpl({required this.myJobsRemoteDataSource});

  @override
  Future<Either<Failures, List<OfferEntity>>> getOffers(String orderId) {
    return myJobsRemoteDataSource.getOffers(orderId);
  }

  @override
  Stream<int> subscribeToOffers({
    required String orderId,
 
  }) {
    return myJobsRemoteDataSource.subscribeToOrderOffersCount(
      orderId: orderId,
 
    );
  }

  @override
  Future<Either<Failures, OfferEntity>> updateOfferStatus(String offerId, String newStatus) {
    return myJobsRemoteDataSource.updateOfferStatus(offerId, newStatus);
  }

  @override
  Future<Either<Failures, OrderEntity>> acceptOfferAndRejectOthers(String orderId, String offerId) {
  return myJobsRemoteDataSource.acceptOfferAndRejectOthers(orderId, offerId);
  }

  @override
  Stream<(OrderEntity, String)>  subscribeToOrders(Map<String, String> filters ) {
 return myJobsRemoteDataSource.subscribeToOrders(filters );
  }
}
