import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/notification_service.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/freelancer/domain/use_cases/send_offer_use_case/send_offer_use_case.dart';

import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/send_offer_view_model/send_offer_view_model_states.dart';

@injectable
class SendOfferViewModel extends Cubit<SendOfferViewModelStates> {
  SendOfferViewModel(this.sendOfferUseCase)
      : super(SendOfferViewModelInitial());
  SendOfferUseCase sendOfferUseCase;

  Future<Either<Failures, OfferEntity>> sendOffer(
    OfferEntity offerEntity,
  ) async {
    try {
      emit(SendOfferViewModelLoading());

      final result = await sendOfferUseCase.call(offerEntity);
      result.fold(
        (failure) =>
            emit(SendOfferViewModelError(errorMessage: failure.message)),
        (offer) =>
            emit(SendOfferViewModelSuccess(message: "Offer sent successfully")),
      );
      await NotificationService().sendNotification(
        receiverId: offerEntity.clientId,
        title: "عرض جديد",
        body:
            "لقد استلمت عرضًا جديدًا على طلبك '${offerEntity.orderName}'. تحقق الآن للاطلاع على التفاصيل.",
      );

      return result;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
