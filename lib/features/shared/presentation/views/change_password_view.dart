import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/shared/presentation/views/widgets/change_password_view_body.dart';

import '../../../../config/l10n/app_localizations.dart';
import '../../../../core/di/di.dart';
import '../../../auth/presentation/cubit/change_password_view_model/change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(

      body: BlocProvider(
           create: (context) =>  getIt<ChangePasswordViewModel>(),
          child: const SafeArea(child: ChangePasswordViewBody())),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

        title: Text(
          local.change_password,
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
    );
  }
}