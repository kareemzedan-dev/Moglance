import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/get_bank_accounts_use_case/get_bank_accounts_use_case.dart';
import 'get_bank_account_view_model_states.dart';
@injectable
class GetBankAccountViewModel extends Cubit<GetBankAccountViewModelStates> {
  final GetBankAccountsUseCase getBankAccountsUseCase;
  StreamSubscription? _subscription;

  GetBankAccountViewModel(this.getBankAccountsUseCase)
      : super(GetBankAccountViewModelStatesInitial());

  void listenToBankAccounts() {
    emit(GetBankAccountViewModelStatesLoading());

    // إلغاء أي اشتراك سابق
    _subscription?.cancel();

    _subscription = getBankAccountsUseCase.call().listen((result) {
      result.fold(
            (failure) {
          emit(GetBankAccountViewModelStatesError(message: failure.message));
        },
            (accounts) {
          emit(GetBankAccountViewModelStatesSuccess(bankAccounts: accounts));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
