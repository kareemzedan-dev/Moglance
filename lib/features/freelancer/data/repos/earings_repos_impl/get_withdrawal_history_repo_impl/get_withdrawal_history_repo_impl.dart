import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../payments/domain/entities/payment_entity.dart';
import '../../../../domain/repos/earings_repos/get_withdrawal_history_repo/get_withdrawal_history_repo.dart';
import '../../../data_sources/remote/earings_remote_data_source/get_withdrawal_history_remote_data_source/get_withdrawal_history_remote_data_source.dart';
@Injectable(as: GetWithdrawalHistoryRepo)
class GetWithdrawalHistoryRepoImpl implements GetWithdrawalHistoryRepo {
  final GetWithdrawalHistoryRemoteDataSource getWithdrawalHistoryRemoteDataSource;
  GetWithdrawalHistoryRepoImpl({required this.getWithdrawalHistoryRemoteDataSource});
  @override
  Future<Either<Failures, List<PaymentEntity>>> getWithdrawalHistory({required String freelancerId}) {
    return getWithdrawalHistoryRemoteDataSource.getWithdrawalHistory(freelancerId: freelancerId);
  }
}