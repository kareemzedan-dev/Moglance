import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/payment_entity.dart';

abstract class CreatePaymentRemoteDataSource {
  Future<Either<Failures, PaymentEntity>> createPayment(PaymentEntity paymentEntity);
}