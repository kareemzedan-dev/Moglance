import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/domain/use_cases/withdraw_offer_use_case/withdraw_offer_use_case.dart';
import 'package:taskly/features/freelancer/presentation/cubit/withdraw_offer_view_model/withdraw_offer_states.dart';
@injectable
class WithdrawOfferViewModel extends Cubit<WithdrawOfferStates> {
  WithdrawOfferViewModel(this.withdrawOfferUseCase)
      : super(WithdrawOfferStatesInitial());
  WithdrawOfferUseCase withdrawOfferUseCase;

  Future<void> withdrawOffer(String offerId, String orderId) async {
    try {
      emit(WithdrawOfferStatesLoading());
      final result = await withdrawOfferUseCase.withdrawOffer(offerId, orderId);
      result.fold(
          (failure) => emit(WithdrawOfferStatesError(message: failure.message)),
          (unit) => emit(WithdrawOfferStatesSuccess(
              message: "Offer withdraw successfully")));
    } catch (e) {
     if (!isClosed) {
    emit(WithdrawOfferStatesError(message: e.toString()));
  }
    }
  }
}
