import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/widgets/request_withdrawal_view_body.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../core/cache/shared_preferences.dart';
import '../../../../../../../../core/di/di.dart';
import '../../../../../../../../core/utils/strings_manager.dart';
import '../../../../../cubit/get_total_earnings_view_model/get_total_earnings_view_model.dart';
import '../../../../../cubit/place_withdrawal_balance_view_model/place_withdrawal_balance_view_model.dart';

class RequestWithdrawalView extends StatelessWidget {
  const RequestWithdrawalView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          local.requestedWithdraw,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        bottom:  PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back, ),
        ),
      ),
      body: MultiBlocProvider(providers:
    [
      BlocProvider(create: (context) => getIt<GetTotalEarningsViewModel>()..getTotalEarnings(SharedPrefHelper.getString(StringsManager.idKey)!),),
    BlocProvider(create: (context) => getIt<PlaceWithdrawalBalanceViewModel>()

    )]
    , child: const RequestWithdrawalViewBody(),)
    );
  }
}