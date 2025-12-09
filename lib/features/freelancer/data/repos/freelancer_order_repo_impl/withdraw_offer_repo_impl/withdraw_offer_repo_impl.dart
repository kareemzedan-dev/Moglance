 import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../../domain/repos/freelancer_order_repo/withdraw_offer_repo/withdraw_offer_repo.dart';
import '../../../data_sources/remote/freelancer_orders/withdraw_offer_remote_data_source/withdraw_offer_remote_data_source.dart';
@Injectable(as: WithdrawOfferRepo)
class WithdrawOfferRepoImpl implements WithdrawOfferRepo {
  final WithdrawOfferRemoteDataSource remoteDataSource;
  WithdrawOfferRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, void>> withdrawOffer(String offerId, String orderId) {
  return remoteDataSource.withdrawOffer(offerId, orderId);
  }


}