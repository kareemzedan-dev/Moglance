import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/core/utils/network_utils.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/client/data/data_sources/remote/my_jobs_remote_data_source.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../core/services/notification_service.dart';
import '../../../../freelancer/data/models/offer_model/offer_model.dart';
import '../../../../shared/data/models/order_dm/order_dm.dart';

@Injectable(as: MyJobsRemoteDataSource)
class MyJobsRemoteDataSourceImpl extends MyJobsRemoteDataSource {
  final SupabaseService supabaseService;

  MyJobsRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<OfferEntity>>> getOffers(String orderId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final response = await supabaseService.supabaseClient
          .from('offers')
          .select()
          .eq('order_id', orderId)
          .eq('status', 'pending');

      if (response.isEmpty) {
        return const Right([]);
      }

      final offers = (response as List)
          .map((json) => OfferModel.fromJson(json).toEntity())
          .toList();

      return Right(offers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<int> subscribeToOrderOffersCount({String orderId = ''}) {
    return supabaseService
        .subscribeToTable(
      table: 'orders',
      filter: "id=eq.$orderId",
    )
        .map((records) {
      if (records.isEmpty) return 0;
      final record = records.first;
      return record['offers_count'] as int? ?? 0;
    });
  }

  @override
  Future<Either<Failures, OfferEntity>> updateOfferStatus(
    String offerId,
    String newStatus,
  ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final response = await supabaseService.updateDataInSupabase(
        tableName: 'offers',
        data: {"status": newStatus},
        match: {"id": offerId},
      );

      if (response != null) {
        final updatedOffer = OfferModel.fromJson(response).toEntity();
        return Right(updatedOffer);
      } else {
        return const Left(ServerFailure("Failed to update offer status"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, OrderEntity>> acceptOfferAndRejectOthers(
      String orderId, String offerId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final offerResponse = await supabaseService.supabaseClient
          .from('offers')
          .select()
          .eq('id', offerId)
          .maybeSingle();

      if (offerResponse == null) {
        return const Left(ServerFailure("Offer not found"));
      }

      final acceptedOffer = OfferModel.fromJson(offerResponse);

      final acceptResponse = await supabaseService.supabaseClient
          .from('offers')
          .update({"status": "accepted"})
          .eq('id', offerId)
          .select()
          .maybeSingle();

      if (acceptResponse == null) {
        return const Left(ServerFailure("Failed to accept the offer"));
      }

      final updateOrderResponse = await supabaseService.supabaseClient
          .from('orders')
          .update({
        "status": "Accepted",
        "budget": acceptedOffer.offerAmount,
        "offer_id": offerId,
        "freelancer_id": acceptedOffer.freelancerId,
      })
          .eq('id', orderId)
          .select()
          .maybeSingle();

      if (updateOrderResponse == null) {
        return const Left(ServerFailure("Failed to update order"));
      }

      await supabaseService.supabaseClient
          .from('offers')
          .update({'status': 'rejected'})
          .eq('order_id', orderId)
          .neq('id', offerId);

      final updatedOrder = OrderDm.fromJson(updateOrderResponse).toEntity();

      // Notification
      final offersResponse = await supabaseService.supabaseClient
          .from('offers')
          .select()
          .eq('order_id', orderId);

      if (offersResponse != null) {
        for (var offerJson in offersResponse) {
          final offer = OfferModel.fromJson(offerJson);
          NotificationService().sendNotification(
            receiverId: offer.freelancerId,
            title: "حاله العروض",
            body: offer.id == offerId
                ?   "لقد تم قبول عرضك المقدم على طلب ${acceptedOffer.orderName} يمكنك الان التواصل مع العميل ."
                : "لقد تم رفض عرضك المقدم على طلب ${acceptedOffer.orderName} يمكنك الان البحث عن طلبات جديده .",
          );
        }
      }


      return Right(updatedOrder);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<(OrderEntity, String)> subscribeToOrders(
      Map<String, dynamic>? filters) {
    final filterString =
        filters?.entries.map((e) => "${e.key}=eq.${e.value}").join(",") ?? "";

    return supabaseService
        .subscribeToTable(
          table: 'orders',
          filter: filterString,
        )
        .asyncExpand((records) => Stream.fromIterable(records.map((record) {
              final order = OrderDm.fromJson(record).toEntity();
              final action = record['action'] as String? ?? "UNKNOWN";
              return (order, action);
            })));
  }
}
