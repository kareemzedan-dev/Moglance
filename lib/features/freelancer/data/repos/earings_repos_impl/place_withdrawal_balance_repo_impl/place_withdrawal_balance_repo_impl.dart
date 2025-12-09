import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../payments/domain/entities/payment_entity.dart';
import '../../../../domain/repos/earings_repos/place_withdrawal_balance_repo/place_withdrawal_balance_repo.dart';
import '../../../data_sources/remote/earings_remote_data_source/place_withdrawal_balance_remote_data_source/place_withdrawal_balance_remote_data_source.dart';
@Injectable(as:  PlaceWithdrawalBalanceRepo)
class PlaceWithdrawalBalanceRepoImpl implements PlaceWithdrawalBalanceRepo {
  final PlaceWithdrawalBalanceRemoteDataSource placeWithdrawalBalanceRemoteDataSource;
  PlaceWithdrawalBalanceRepoImpl({required this.placeWithdrawalBalanceRemoteDataSource});

  @override
  Future<Either<Failures, void>> placeWithdrawalBalance({required PaymentEntity paymentEntity}) {
    return placeWithdrawalBalanceRemoteDataSource.placeWithdrawalBalance(paymentEntity: paymentEntity);
  }


}