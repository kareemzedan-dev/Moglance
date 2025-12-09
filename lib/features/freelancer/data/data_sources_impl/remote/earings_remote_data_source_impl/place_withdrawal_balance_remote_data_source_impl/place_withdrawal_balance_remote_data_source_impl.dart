import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/utils/network_utils.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/earings_remote_data_source/place_withdrawal_balance_remote_data_source/place_withdrawal_balance_remote_data_source.dart';
@Injectable(as: PlaceWithdrawalBalanceRemoteDataSource)
class PlaceWithdrawalBalanceRemoteDataSourceImpl
    implements PlaceWithdrawalBalanceRemoteDataSource {
  final SupabaseService supabaseService;

  PlaceWithdrawalBalanceRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, void>> placeWithdrawalBalance({PaymentEntity? paymentEntity}) async {
    if (paymentEntity == null) {
      return Left(Failures('Payment entity is required'));
    }

    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(Failures('No internet connection'));
      }

      final amount = paymentEntity.amount;
      final freelancerId = paymentEntity.freelancerId;

      // 1️⃣ إضافة سجل السحب
      await supabaseService.supabaseClient.from('payments').insert({
        'freelancer_id': freelancerId,
        'amount': amount,
        'status': paymentEntity.status,
        'payment_method': paymentEntity.paymentMethod,
        'account_number': paymentEntity.accountNumber,
        'requester_type': "freelancer",
        'created_at': paymentEntity.createdAt.toIso8601String(),
        'updated_at': paymentEntity.updatedAt.toIso8601String(),
      });

      // 2️⃣ خصم الرصيد عبر RPC
      await supabaseService.supabaseClient.rpc(
        'decrement_balance',
        params: {
          'freelancer_id': freelancerId,
          'amount_to_decrement': amount,
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }
}

