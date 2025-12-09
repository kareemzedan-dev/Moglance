import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/freelancer_orders/withdraw_offer_remote_data_source/withdraw_offer_remote_data_source.dart';
@Injectable(as: WithdrawOfferRemoteDataSource)
class WithdrawOfferRemoteDataSourceImpl implements WithdrawOfferRemoteDataSource {
  final SupabaseService _supabaseService;
  WithdrawOfferRemoteDataSourceImpl(this._supabaseService);


  @override
  Future<Either<Failures, void>> withdrawOffer(
      String offerId, String orderId) async {
    try {
      await _supabaseService.supabaseClient
          .from('offers')
          .update({'status': 'withdrawn'}).eq('id', offerId);

      await _supabaseService.supabaseClient.rpc(
        'decrement_offers_count',
        params: {'order_id': orderId},
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to withdraw offer: $e'));
    }
  }


}