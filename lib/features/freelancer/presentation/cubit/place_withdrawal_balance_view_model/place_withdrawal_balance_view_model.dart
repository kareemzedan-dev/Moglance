import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/presentation/cubit/place_withdrawal_balance_view_model/place_withdrawal_balance_states.dart';

import '../../../../payments/domain/entities/payment_entity.dart';
import '../../../domain/use_cases/place_withdrawal_balance_use_case/place_withdrawal_balance_use_case.dart';
@injectable
class PlaceWithdrawalBalanceViewModel extends Cubit<PlaceWithdrawalBalanceStates>{
  final PlaceWithdrawalBalanceUseCase placeWithdrawalBalanceUseCase;
  PlaceWithdrawalBalanceViewModel(this.placeWithdrawalBalanceUseCase) : super(PlaceWithdrawalBalanceInitial());
  Future<void> placeWithdrawalBalance(PaymentEntity paymentEntity) async {
    try {
      emit(PlaceWithdrawalBalanceLoadingState());
      final result = await placeWithdrawalBalanceUseCase.call(paymentEntity:  paymentEntity );
      result.fold(
        (failure) => emit(PlaceWithdrawalBalanceErrorState(message: failure.message)),
          (unit) => emit(PlaceWithdrawalBalanceSuccessState())
          );


    }
    catch (e) {
      emit(PlaceWithdrawalBalanceErrorState(message: e.toString()));

    }
  }

}