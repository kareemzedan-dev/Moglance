
import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/payment_entity.dart';


abstract class PaymentRepos {
  Future<Either<Failures, PaymentEntity>> createPayment(PaymentEntity paymentEntity) ;
  Future<Either<Failures, PaymentEntity>>  getPayment(String orderId) ;
}