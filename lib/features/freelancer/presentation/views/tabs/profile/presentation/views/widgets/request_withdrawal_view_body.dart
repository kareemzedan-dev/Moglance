import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/components/custom_tab_bar.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_withdrawal_history_view_model/get_withdrawal_history_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/widgets/withdrawal_history_tab_content.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/widgets/withdrawal_request_tab_content.dart';

import '../../../../../../cubit/get_withdrawal_history_view_model/get_withdrawal_history_states.dart';

class RequestWithdrawalViewBody extends StatelessWidget {
  const RequestWithdrawalViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            CustomTabBar(tabs: [local.withdrawalRequest, local.withdrawalHistory]),
            Expanded(
              child: TabBarView(
                children: [
                  WithdrawalRequestTabContent(),
                  BlocProvider(
                    create:  (context) => getIt<GetWithdrawalHistoryViewModel>()..getWithdrawalHistory(SharedPrefHelper.getString(StringsManager.idKey)!),
                    child: BlocBuilder<GetWithdrawalHistoryViewModel,
                        GetWithdrawalHistoryStates>(
                      builder: (context, state) {
                        if (state is GetWithdrawalHistoryLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state is GetWithdrawalHistorySuccessState) {
                          if (state.withdrawalHistoryEntity.isEmpty) {
                            return Center(child: Text(local.withdrawalHistoryEmpty));
                          }
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.withdrawalHistoryEntity.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: WithdrawalHistoryTabContent(
                                  payment: state.withdrawalHistoryEntity[index],
                                ),
                              );
                            },
                          );
                        }
                        if (state is GetWithdrawalHistoryErrorState) {
                          return Center(
                            child: Text(local.somethingWentWrongTryAgain),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}