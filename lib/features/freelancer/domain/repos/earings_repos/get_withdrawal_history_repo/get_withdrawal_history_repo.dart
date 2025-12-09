import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../payments/domain/entities/payment_entity.dart';

abstract class GetWithdrawalHistoryRepo {
  Future<Either<Failures, List<PaymentEntity>>> getWithdrawalHistory({required String freelancerId});
}