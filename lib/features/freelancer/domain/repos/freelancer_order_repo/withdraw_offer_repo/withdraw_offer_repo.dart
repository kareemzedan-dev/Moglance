import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class WithdrawOfferRepo {
  Future<Either<Failures, void>> withdrawOffer(String offerId, String orderId);
}