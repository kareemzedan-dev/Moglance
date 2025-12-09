import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/domain/use_cases/get_earning_use_case/get_earning_use_case.dart';

import 'get_total_earnings_states.dart';

@injectable
class GetTotalEarningsViewModel extends Cubit<GetTotalEarningsStates> {
  final GetEarningUseCase getEarningUseCase;

  GetTotalEarningsViewModel(this.getEarningUseCase)
      : super(GetTotalEarningsInitial());

  Future<void> getTotalEarnings(String freelancerId) async {
    try {
      emit(GetTotalEarningsLoadingState());
      final result = await getEarningUseCase.call(freelancerId: freelancerId);
      result.fold(
          (failure) =>
              emit(GetTotalEarningsErrorState(message: failure.message)),
          (earningsEntity) => emit(
              GetTotalEarningsSuccessState(earningsEntity: earningsEntity)));
    } catch (e) {
      emit(GetTotalEarningsErrorState(message: e.toString()));
    }
  }
}
