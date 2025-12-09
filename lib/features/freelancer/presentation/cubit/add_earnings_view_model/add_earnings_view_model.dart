import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/domain/use_cases/add_earning_use_case/add_earning_use_case.dart';

import 'add_earnings_states.dart';
@injectable
class AddEarningsViewModel extends Cubit<AddEarningsStates> {
  final AddEarningUseCase addEarningsUseCase;

  AddEarningsViewModel(this.addEarningsUseCase) : super(AddEarningsInitial());

  Future<void> addEarnings(String freelancerId, double amount,   String clientId,) async {
    try {
      emit(AddEarningsLoadingState());
      final result = await addEarningsUseCase.addEarning(

          freelancerId: freelancerId, amount: amount,clientId: clientId, );
      result.fold(
          (failure) => emit(AddEarningsErrorState(message: failure.message)),
          (unit) => emit(AddEarningsSuccessState()));
    } catch (e) {
      emit(AddEarningsErrorState(message: e.toString()));
    }
  }
}
