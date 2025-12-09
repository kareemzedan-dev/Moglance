import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';

import '../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class MyJobsRemoteDataSource {
  Future<Either<Failures, List<OfferEntity>>> getOffers(String orderId);

  // إضافة subscribe method للـ realtime
  Stream<int> subscribeToOrderOffersCount({
      String orderId,
 
  });
  Future< Either<Failures, OfferEntity >> updateOfferStatus(
      String offerId, String newStatus);

  Future<Either<Failures, OrderEntity>> acceptOfferAndRejectOthers(
      String orderId,
  String offerId,
      );

   Stream<(OrderEntity, String)> subscribeToOrders(
      Map<String, dynamic>? filters,
 
      );
}
