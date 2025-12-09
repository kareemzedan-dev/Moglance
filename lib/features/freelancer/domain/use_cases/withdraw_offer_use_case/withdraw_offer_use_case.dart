import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/domain/repos/freelancer_order_repo/withdraw_offer_repo/withdraw_offer_repo.dart';
@injectable
class WithdrawOfferUseCase {
     WithdrawOfferRepo withdrawOfferRepo ;

    WithdrawOfferUseCase(this.withdrawOfferRepo);

    Future<Either<Failures, void>> withdrawOffer(String offerId, String orderId) => withdrawOfferRepo.withdrawOffer( offerId,orderId);
}