import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';
import 'package:taskly/features/payments/domain/repositories/payment_repos/payment_repo.dart';

@injectable
class GetPaymentUseCase {
  PaymentRepos paymentRepos;
  GetPaymentUseCase(this.paymentRepos);
  Future<Either<Failures, PaymentEntity>> call(String orderId) async {
    return await paymentRepos.getPayment(orderId);
  }
}