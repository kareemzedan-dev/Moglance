import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

abstract class PlaceWithdrawalBalanceRepo {
  Future<Either<Failures,void>> placeWithdrawalBalance( {required PaymentEntity paymentEntity});
}