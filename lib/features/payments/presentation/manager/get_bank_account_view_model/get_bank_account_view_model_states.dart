
import '../../../domain/entities/bank_accounts_entity/bank_accounts_entity.dart';

class GetBankAccountViewModelStates {}

class GetBankAccountViewModelStatesInitial
    extends GetBankAccountViewModelStates {}

class GetBankAccountViewModelStatesLoading
    extends GetBankAccountViewModelStates {}

class GetBankAccountViewModelStatesSuccess
    extends GetBankAccountViewModelStates {
  final List<BankAccountsEntity> bankAccounts;

  GetBankAccountViewModelStatesSuccess({required this.bankAccounts});
}

class GetBankAccountViewModelStatesError
    extends GetBankAccountViewModelStates {
  final String message;

  GetBankAccountViewModelStatesError({required this.message});
}
