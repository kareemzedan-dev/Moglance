import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/core/utils/network_utils.dart';
import 'package:taskly/features/freelancer/data/data_sources/remote/offer_data_source.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../shared/data/models/order_dm/order_dm.dart';
import '../../models/offer_model/offer_model.dart';


@Injectable(as: OfferRemoteDataSource)
class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  final SupabaseService supabaseService  ;

  OfferRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, OfferEntity>> placeOffer(
      OfferEntity offerEntity) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }


      final offerModel = OfferModel(
        id: offerEntity.id,
        freelancerId: offerEntity.freelancerId,
        clientId: offerEntity.clientId,
        orderId: offerEntity.orderId,
        offerAmount: offerEntity.offerAmount,
        offerStatus: offerEntity.offerStatus,
        offerDescription: offerEntity.offerDescription,
        offerDeliveryTime: offerEntity.offerDeliveryTime,
        createdAt: offerEntity.createdAt,
        updatedAt: offerEntity.updatedAt,
        orderName: offerEntity.orderName,
      );

      final response = await supabaseService.sendDataToSupabase(
        tableName: "offers",
        data: offerModel.toJson(),
      );


      final orderId = offerEntity.orderId;
      final order = await supabaseService.supabaseClient
          .from('orders')
          .select('offers_count')
          .eq('id', orderId)
          .maybeSingle();

      final currentCount = order?['offers_count'] ?? 0;

      await supabaseService.supabaseClient
          .from('orders')
          .update({'offers_count': currentCount + 1}).eq('id', orderId);

      var offer = OfferModel.fromJson(response!);
      return Right(offer);
    } catch (e) {
      return Left(ServerFailure('Error while placing offer: $e'));
    }
  }

  @override
  Future<Either<Failures, List<OfferEntity>>> getFreelancerOffers(
      String freelancerId, String status) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }


      final query = supabaseService.supabaseClient
          .from('offers')
          .select()
          .eq('freelancer_id', freelancerId)
          .neq('status', 'withdrawn');

      if (status != 'all') {
        query.eq('status', status);
      }

      final response = await query;

      if ((response.isEmpty)) {
        return const Right([]);
      }

      final offers = (response as List)
          .map((json) => OfferModel.fromJson(json).toEntity())
          .toList();

      return Right(offers);
    } catch (e) {
      return Left(ServerFailure('Error while fetching freelancer offers: $e'));
    }
  }

  @override
  Future<Either<Failures, OrderEntity>> fetchOrderDetails(
      String orderId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }


      final orderResponse = await supabaseService.supabaseClient
          .from('orders')
          .select()
          .eq('id', orderId)
          .maybeSingle();

      if (orderResponse == null) {
        return const Left(ServerFailure('Order not found'));
      }

      final order = OrderDm.fromJson(orderResponse);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure('Error while fetching order details: $e'));
    }
  }

  @override
  Stream<(OfferEntity, String)> subscribeToOffers(String freelancerId) {
    return supabaseService
        .subscribeToTable(
          table: 'offers',
          filter: "freelancer_id=eq.$freelancerId",
        )
        .map((records) {
          return records.map((record) {
            final offer = OfferModel.fromJson(record).toEntity();
            final action = record['action'] as String? ?? 'unknown';
            return (offer, action);
          });
        })
        // flatMap عشان كل event يبقى فردي مش list
        .asyncExpand((events) => Stream.fromIterable(events));
  }
}
