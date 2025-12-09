import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/shared/presentation/views/widgets/user_account_view_body.dart';

import '../../../../config/l10n/app_localizations.dart';
import '../../../profile/domain/entities/user_info_entity/user_info_entity.dart';

class UserAccountView extends StatelessWidget {
  const UserAccountView({super.key, required this.userInfoEntity});
  final UserInfoEntity userInfoEntity;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(
      body: SafeArea(child: UserAccountViewBody( userInfoEntity: userInfoEntity)),
      appBar:  AppBar(
        surfaceTintColor: Colors.transparent,

        title: Text(
          local.account,
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