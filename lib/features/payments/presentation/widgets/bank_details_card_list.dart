import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/dismissible_error_card.dart';
import '../manager/get_bank_account_view_model/get_bank_account_view_model.dart';
import '../manager/get_bank_account_view_model/get_bank_account_view_model_states.dart';
import 'bank_details_card.dart';

class BankDetailsCardList extends StatelessWidget {
  const BankDetailsCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBankAccountViewModel, GetBankAccountViewModelStates>(
      builder: (context, state) {
        if (state is GetBankAccountViewModelStatesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is GetBankAccountViewModelStatesError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showTemporaryMessage(context, state.message, MessageType.error);
          });
        }
        if (state is GetBankAccountViewModelStatesSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.bankAccounts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BankDetailsCard(
                  bankAccountsEntity: state.bankAccounts[index],
                ),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
