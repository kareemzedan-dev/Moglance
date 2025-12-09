
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../payments/domain/entities/payment_entity.dart';
import '../../repos/earings_repos/get_withdrawal_history_repo/get_withdrawal_history_repo.dart';
@injectable
  class GetWithdrawalHistoryUseCase {
    final GetWithdrawalHistoryRepo getWithdrawalHistoryRepo;
    GetWithdrawalHistoryUseCase({required this.getWithdrawalHistoryRepo});
    Future<Either<Failures, List<PaymentEntity>>> getWithdrawalHistory({required String freelancerId}) => getWithdrawalHistoryRepo.getWithdrawalHistory(freelancerId: freelancerId);
 }