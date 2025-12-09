import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/payments/domain/repositories/payment_repos/payment_repo.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/payment_entity.dart';

@injectable
class CreatePaymentUseCase {
  PaymentRepos createPaymentRepo;
  CreatePaymentUseCase(this.createPaymentRepo);
  Future<Either<Failures, PaymentEntity>> call(PaymentEntity paymentEntity) async {
    return await createPaymentRepo.createPayment(paymentEntity);
  }

}