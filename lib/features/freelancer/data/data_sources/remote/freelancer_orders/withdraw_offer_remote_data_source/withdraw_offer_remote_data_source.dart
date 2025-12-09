import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';

abstract class WithdrawOfferRemoteDataSource {
  Future<Either<Failures, void>> withdrawOffer(  String offerId, String orderId);
}