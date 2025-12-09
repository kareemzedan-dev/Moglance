import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/network_utils.dart';
import '../../../domain/entities/offer_entity/offer_entity.dart';
import '../../../domain/use_cases/get_freelancer_offers_use_case/get_freelancer_offers_use_case.dart';
import 'get_freelancer_offers_states.dart';

@injectable
class GetFreelancerOffersViewModel extends Cubit<GetFreelancerOffersStates> {
  final GetFreelancerOffersUseCase getFreelancerOffersUseCase;

  GetFreelancerOffersViewModel(this.getFreelancerOffersUseCase)
      : super(GetFreelancerOffersLoadingState());
Future<Either<Failures, List<OfferEntity>>> getFreelancerOffers(
    String freelancerId,
    [String? status]) async {

  if (isClosed) return Left(ServerFailure("Cubit is closed"));

  emit(GetFreelancerOffersLoadingState());

  try {
    final result = await getFreelancerOffersUseCase.call(
        freelancerId, status ?? "all");

    if (isClosed) return result;

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(GetFreelancerOffersErrorState(failure.message));
        }
      },
      (offers) {
        if (!isClosed) {
          final modifiableOffers = List<OfferEntity>.from(offers)
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          emit(GetFreelancerOffersSuccessState(modifiableOffers));
        }
      },
    );

    return result;

  } catch (e) {
    if (!isClosed) {
      emit(GetFreelancerOffersErrorState(e.toString()));
    }
    return Left(ServerFailure(e.toString()));
  }
}


Stream<(OfferEntity, String)> subscribeToOffers(String freelancerId) {
  return getFreelancerOffersUseCase.subscribeToOffers(freelancerId);
}
  StreamSubscription? _subscription;

  void listenToOffersChanges(String freelancerId) {
    // نلغي أي اشتراك قديم
    _subscription?.cancel();

 _subscription = subscribeToOffers(freelancerId).listen((event) async {
  if (isClosed) return; // 🔥 وقف أي تحديث لو الكيوبت اتقفل

  final (offer, action) = event;
  print("📡 Offer change detected: ${offer.id} (${offer.offerStatus}) - $action");

  await getFreelancerOffers(freelancerId);
});

  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

}
