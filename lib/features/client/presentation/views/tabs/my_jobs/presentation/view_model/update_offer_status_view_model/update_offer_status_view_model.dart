import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/client/domain/use_cases/my_jobs/accept_offer_use_case/accept_offer_use_case.dart';
import 'package:taskly/features/client/domain/use_cases/my_jobs/update_offer_status_use_case/update_offer_status_use_case.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_states.dart';

@injectable
class UpdateOfferStatusViewModel extends Cubit<UpdateOfferStatusStates> {
  UpdateOfferStatusViewModel(this.updateOfferStatusUseCase, this.acceptOfferUseCase)
    : super(UpdateOfferStatusInitial());
  UpdateOfferStatusUseCase updateOfferStatusUseCase;
  AcceptOfferUseCase acceptOfferUseCase;

  void updateOfferStatus(String offerId, String newStatus) async {
    try {
      emit(UpdateOfferStatusLoadingState());
      var result = await updateOfferStatusUseCase.updateOfferStatus(offerId, newStatus);
      result.fold(
        (l) => emit(UpdateOfferStatusErrorState(l.message)),
        (r) => emit(UpdateOfferStatusSuccessState("Offer status updated successfully")),
      );

    } catch (e) {
      emit(UpdateOfferStatusErrorState(e.toString()));
    }
  }


  void acceptOfferAndRejectOthers(String orderId, String offerId) async {
    try {
      emit(UpdateOfferStatusLoadingState());

      var result = await acceptOfferUseCase.acceptOfferAndRejectOthers(orderId, offerId);

      result.fold(
            (l) => emit(UpdateOfferStatusErrorState(l.message)),
            (r) => emit(UpdateOfferStatusSuccessState("Offer accepted successfully")),
      );
    } catch (e) {
      emit(UpdateOfferStatusErrorState(e.toString()));
    }
  }

}
