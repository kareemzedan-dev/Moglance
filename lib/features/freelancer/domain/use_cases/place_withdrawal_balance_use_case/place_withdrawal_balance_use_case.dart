import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

import '../../repos/earings_repos/place_withdrawal_balance_repo/place_withdrawal_balance_repo.dart';
@injectable
 class PlaceWithdrawalBalanceUseCase {
   final PlaceWithdrawalBalanceRepo placeWithdrawalBalanceRepo;
   PlaceWithdrawalBalanceUseCase({required this.placeWithdrawalBalanceRepo});
   Future<Either<Failures,void>> call({required PaymentEntity paymentEntity}) => placeWithdrawalBalanceRepo.placeWithdrawalBalance(paymentEntity: paymentEntity);
 }