import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskly/features/messages/presentation/manager/send_message_view_model/send_message_view_model.dart';

import 'package:taskly/features/messages/presentation/widgets/chat_with_admin_view_body.dart';

import '../../../../config/l10n/app_localizations.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/colors_manger.dart';
import '../../../attachments/presentation/manager/download_attachments_view_model/download_attachments_view_model.dart';
import '../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import '../../../client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart';
import '../manager/chat_with_admin_view_model/chat_with_admin_view_model.dart';
import '../manager/get_admin_messages_view_model/get_admin_messages_view_model.dart';
import '../manager/pending_messages_view_model/pending_messages_view_model.dart';
import '../manager/send_to_admin_messages_view_model/send_to_admin_messages_view_model.dart';
import '../manager/subscribe_to_admin_messages_view_model/subscribe_to_admin_messages_view_model.dart';

class AdminChatView extends StatelessWidget {
  const AdminChatView({
    super.key,
    required this.currentUserId,
  });

  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    final local =AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider<PendingMessagesViewModel>(
          create: (_) => getIt<PendingMessagesViewModel>(),
        ),


        BlocProvider(create:  (context) => getIt<UploadAttachmentsViewModel>(),),
        BlocProvider(create: (_) => getIt<DownloadAttachmentsViewModel>()),
        BlocProvider(create: (_) => getIt<SendToAdminMessagesViewModel>()),

        BlocProvider(
          create: (_) => getIt<GetAdminMessagesViewModel>(),
        ),
        BlocProvider(
            create: (_) => getIt<SubscribeToAdminMessagesViewModel>()  ),
        BlocProvider(create:  (context) => getIt<UpdateOfferStatusViewModel>(),),
        ChangeNotifierProvider(create: (_) => PendingMessagesViewModel()),
        BlocProvider(create:  (context) => getIt<UploadAttachmentsViewModel>(),),

        BlocProvider(create: (_) => getIt<ChatWithAdminViewModel>()..loadMessagesAndSubscribe(
          currentUserId
        ) ),

      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.white,
          leading: IconButton(
            icon:const   Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom:  const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),

          title:   Text(local.chat_with_admin,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
            color: ColorsManager.black,
              ),
          ),
        ) ,
        body: SafeArea(
          child: ChatWithAdminViewBody(
            currentUserId: currentUserId,

          )
        ),
      ),
    );
  }
}
