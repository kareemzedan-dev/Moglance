import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_total_earnings_view_model/get_total_earnings_states.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_total_earnings_view_model/get_total_earnings_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/widgets/analytics_row.dart';

class FreelancerEarningViewBody extends StatelessWidget {
  const FreelancerEarningViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<GetTotalEarningsViewModel, GetTotalEarningsStates>(
        builder: (context, state) {
          if (state is GetTotalEarningsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetTotalEarningsErrorState) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
                const SizedBox(height: 20),
                Text("تحقق من اتصالك بالانترنت"),
              ],
            ));
          }
          if (state is GetTotalEarningsSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "${state.earningsEntity.balance.toString()} ${local.sar}",
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primary,
                        fontSize: 30.sp,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      local.availableForWithdrawal,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    local.analytics,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 10.h),
                  AnalyticsRow(title: local.totalEarnings, value: state.earningsEntity.totalEarnings.toString()),
                  AnalyticsRow(title: local.availableForWithdrawal, value: state.earningsEntity.balance.toString()),
                  AnalyticsRow(title: local.totalOrders, value: state.earningsEntity.totalOrders.toString()),
                  AnalyticsRow(title: local.completedOrders, value: state.earningsEntity.completedOrders.toString()),
                  Spacer(),
                  CustomButton(
                    title: local.requestWithdrawal,
                    ontap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.requestWithdrawalView,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }
}