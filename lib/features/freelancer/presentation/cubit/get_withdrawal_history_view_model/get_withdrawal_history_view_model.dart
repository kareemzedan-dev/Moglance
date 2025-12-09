

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/get_withdrawal_history_use_case/get_withdrawal_history_use_case.dart';
import 'get_withdrawal_history_states.dart';
@injectable
class GetWithdrawalHistoryViewModel extends Cubit<GetWithdrawalHistoryStates>{
  final GetWithdrawalHistoryUseCase getWithdrawalHistoryUseCase;
  GetWithdrawalHistoryViewModel(this.getWithdrawalHistoryUseCase) : super(GetWithdrawalHistoryInitial());

  Future<void> getWithdrawalHistory(String freelancerId) async {
     try
         {
            emit(GetWithdrawalHistoryLoadingState());
            final result = await getWithdrawalHistoryUseCase.getWithdrawalHistory(freelancerId: freelancerId);
            result.fold(
              (failure) => emit(GetWithdrawalHistoryErrorState(message: failure.message)),
                (withdrawalHistoryEntity) => emit(GetWithdrawalHistorySuccessState(withdrawalHistoryEntity: withdrawalHistoryEntity))
                );


         }
         catch (e) {
        emit(GetWithdrawalHistoryErrorState(message: e.toString()));
         }
  }
}