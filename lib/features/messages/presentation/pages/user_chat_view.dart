import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import 'package:taskly/features/messages/presentation/manager/messages_view_model/messages_view_model.dart';

import 'package:taskly/features/messages/presentation/widgets/chat_view_body.dart';
import 'package:taskly/features/messages/presentation/widgets/custom_app_bar.dart';
import 'package:taskly/features/reviews/presentation/manager/submit_rating_view_model/submit_rating_view_model.dart';

import '../../../../config/l10n/app_localizations.dart';
import '../../../../config/routes/routes_manager.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/components/confirmation_dialog.dart';
import '../../../../core/di/di.dart';
import '../../../attachments/presentation/manager/download_attachments_view_model/download_attachments_view_model.dart';
import '../../../client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart';
import '../../../freelancer/presentation/cubit/add_earnings_view_model/add_earnings_view_model.dart';
import '../../../freelancer/presentation/cubit/update_order_status_view_model/update_order_status_view_model.dart';
import '../../../freelancer/presentation/views/tabs/find_work/presentation/view_model/get_commission_view_model/get_commission_view_model.dart';
import '../../../reviews/presentation/manager/get_user_reviews_view_model/get_user_reviews_view_model.dart';
import '../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../shared/presentation/manager/subscribe_to_order_record_view_model/subscribe_to_order_record_view_model.dart';
import '../manager/mark_message_as_read_view_model/mark_message_as_read_view_model.dart';
import '../manager/pending_messages_view_model/pending_messages_view_model.dart';
import '../manager/unread_messages_badge_view_model/unread_messages_badge_view_model.dart';
import '../manager/user_status_view_model/user_status_states.dart';
import '../manager/user_status_view_model/user_status_view_model.dart';
import '../widgets/admin_message_card.dart';
import '../widgets/chat_header_section.dart';
import '../widgets/order_status_card.dart';
import '../widgets/privacy_agreement_dialog.dart';

class UserChatView extends StatefulWidget {
  const UserChatView({
    super.key,
    required this.currentUserName,
    required this.receiverName,
    required this.currentUserAvatar,
    required this.receiverAvatar,
    required this.order,
    required this.currentUserId,
    required this.receiverId,
  });


  final String currentUserName;
  final String receiverName;

  final OrderEntity order;
  final String currentUserAvatar;
  final String receiverAvatar;
  final String currentUserId;
  final String receiverId;

  @override
  State<UserChatView> createState() => _UserChatViewState();
}

class _UserChatViewState extends State<UserChatView> {
  bool _hasAgreed = false;

  @override
  void initState() {
    super.initState();
    _checkAgreement();
  }

  Future<void> _checkAgreement() async {

    final agreed = SharedPrefHelper.getBool('agreed_${widget.order.id}') ?? false;

    if (!agreed) {
      // المستخدم لسه ما وافقش
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => PrivacyAgreementDialog(
            onAgree: () async {
              await SharedPrefHelper.setBool('agreed_${widget.order.id}', true);
              setState(() => _hasAgreed = true);
              Navigator.pop(context);
            },
            onDisagree: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        );
      });
    } else {
      setState(() => _hasAgreed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!; // <-- استدعاء الـ localization
    final viewModel = getIt<SubscribeOrdersRecordViewModel>();
    final adminMessage = viewModel.getAdminMessage(widget.order, local);



    return MultiBlocProvider(
      providers: [
         BlocProvider(create: (_) => getIt<SubmitRatingViewModel>()),
        BlocProvider(create: (_) => getIt<GetUserReviewsViewModel>()..getUserReviews(widget.currentUserId, widget.order.clientId == widget.currentUserId ? "client" : "freelancer")),
        BlocProvider(create: (_) => getIt<DownloadAttachmentsViewModel>()),
        BlocProvider(create: (_) => getIt<UpdateOrderStatusViewModel>()),
        BlocProvider(
          create: (_) => getIt<UserStatusViewModel>()..streamUserStatus(widget.receiverId),
        ),
        BlocProvider(
          create: (_) => getIt<MessagesViewModel>()
        ),
        BlocProvider(
          create: (context) => getIt<GetCommissionViewModel>(),
        ),
        BlocProvider(
          create: (context) => getIt<AddEarningsViewModel>(),
        ),
        BlocProvider(
          create: (context) => getIt<UpdateOfferStatusViewModel>(),
        ),
        ChangeNotifierProvider(create: (_) => PendingMessagesViewModel()),
        BlocProvider(
          create: (context) => getIt<UploadAttachmentsViewModel>(),
        ),
        BlocProvider(
          create: (_) {
            final vm = getIt<SubscribeOrdersRecordViewModel>();
            vm.subscribe(widget.order.id);
            return vm;
          },
        ),
        BlocProvider(
          create: (_) {
            final badgeVM = getIt<UnreadMessagesBadgeViewModel>();
            badgeVM.start(widget.order.id, widget.currentUserId, widget.receiverId);

            final markVM = getIt<MarkMessageAsReadViewModel>();
            markVM.markMessagesAsRead(widget.order.id, widget.currentUserId );
            return badgeVM;
          },
        ),


        BlocProvider(
          create: (_) {
            return getIt<MarkMessageAsReadViewModel>();

          },
        ),


      ],
      child: BlocBuilder<UserStatusViewModel, UserStatusStates>(
        builder: (context, state) {
          bool isOnline = false;
          DateTime lastSeen = DateTime.now();

          if (state is UserStatusSuccessStates) {
            isOnline = state.userStatus.isOnline;
            lastSeen = state.userStatus.lastSeen;
          }

          return Scaffold(
            appBar: customAppBar(
              context,
              userName: widget.receiverName,
              userImage: widget.receiverAvatar,
              order: widget.order,
              isOnline: isOnline,
              lastSeen: lastSeen,

            ),
            body: SafeArea(
              child: Column(
                children: [
                  ChatHeaderSection(
                    order: widget.order,
                    currentUserId: widget.currentUserId,

                  ),

                  Expanded(
                    child: ChatViewBody(
                      currentUserName: widget.currentUserName,
                      receiverName: widget.receiverName,
                      currentUserAvatar: widget.currentUserAvatar,
                      receiverAvatar: widget.receiverAvatar,
                      currentUserRole: widget.order.clientId == widget.currentUserId
                          ? 'client'
                          : 'freelancer',
                      receiverUserRole: widget.order.clientId == widget.currentUserId
                          ? 'freelancer'
                          : 'client',
                      orderId: widget.order.id,
                      currentUserId: widget.currentUserId,
                      receiverId: widget.receiverId,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}