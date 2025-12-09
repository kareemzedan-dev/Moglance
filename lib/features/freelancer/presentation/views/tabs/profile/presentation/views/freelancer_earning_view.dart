import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_total_earnings_view_model/get_total_earnings_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/widgets/freelancer_earning_view_body.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';

class FreelancerEarningView extends StatelessWidget {
  const FreelancerEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

        title: Text(
            local.earnings,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
   leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
        elevation: 0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),

      body:   SafeArea(child: BlocProvider(
          create:  (context) => getIt<GetTotalEarningsViewModel>()..getTotalEarnings(SharedPrefHelper.getString(StringsManager.idKey)!),
          child: FreelancerEarningViewBody())),
    );
  }
}