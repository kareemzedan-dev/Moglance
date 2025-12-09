import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../../../payments/domain/entities/payment_entity.dart';
import '../../../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../../data_sources/remote/earings_remote_data_source/get_withdrawal_history_remote_data_source/get_withdrawal_history_remote_data_source.dart';

@Injectable(as: GetWithdrawalHistoryRemoteDataSource)
class GetWithdrawalHistoryRemoteDataSourceImpl implements GetWithdrawalHistoryRemoteDataSource {
  final SupabaseService supabaseService;

  GetWithdrawalHistoryRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, List<PaymentEntity>>> getWithdrawalHistory({
    required String freelancerId,
  }) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(Failures('No internet connection'));
      }
      final response = await supabaseService.supabaseClient
          .from('payments')
          .select()
          .eq('freelancer_id', freelancerId)
          .order('created_at', ascending: false);

      if (response == null) {
        return const Right([]);
      }

// فلترة على requester_type
      final filteredResponse = (response as List<dynamic>)
          .where((data) => data['requester_type'] == 'freelancer')
          .toList();

      final payments = filteredResponse.map((data) {
        print("Processing payment data: $data");

        return PaymentEntity.forFreelancer(
          id: data['id'] ?? '',
          freelancerId: data['freelancer_id'] ?? '',
          amount: (data['amount'] != null ? (data['amount'] as num).toDouble() : 0.0),
          status: data['status'] ?? '',
          createdAt: data['created_at'] != null
              ? DateTime.tryParse(data['created_at']) ?? DateTime.now()
              : DateTime.now(),
          updatedAt: data['updated_at'] != null
              ? DateTime.tryParse(data['updated_at']) ?? DateTime.now()
              : DateTime.now(),
          paymentMethod: data['payment_method'] ?? '',
          accountNumber: data['account_number'] ?? '',
        );
      }).toList();

      print("Mapped payments: $payments");

      return Right(payments);

    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }
}
