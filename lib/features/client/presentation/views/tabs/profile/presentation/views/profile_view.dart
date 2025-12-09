import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/components/custom_app_bar.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/components/circle_icon_button.dart';
import 'package:taskly/features/client/presentation/views/tabs/profile/presentation/views/widgets/client_profile_view_body.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';

class ClientProfileViewTab extends StatelessWidget {
  const ClientProfileViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: local.profile,
        image: Assets.assetsImagesSettings,
      ),

      body: const ClientProfileViewBody(),
    );
  }
}
