import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/messages/presentation/widgets/messages_tab_view_body.dart';

import '../../../../config/l10n/app_localizations.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../manager/messages_view_model/messages_view_model.dart';
import '../manager/unread_messages_badge_view_model/unread_messages_badge_view_model.dart';
import '../widgets/admin_conversation_card.dart';

class UserMessagesTabView extends StatelessWidget {
  const UserMessagesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final local =AppLocalizations.of(context)!;
    return Scaffold(
      appBar:  CustomAppBar(
        title: local.messages,
        image: Assets.assetsImagesChat6431892,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesManager.adminChatView,
                      arguments: {
                        "currentUserId":
                            SharedPrefHelper.getString(StringsManager.idKey),


                      });
                },
                child: const AdminConversationCard()),
            MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<MessagesViewModel>()),
                  BlocProvider(create: (context) => getIt<UnreadMessagesBadgeViewModel>()),
                ],
                child: const UserMessagesTabViewBody()),
          ],
        ),
      )),
    );
  }
}
