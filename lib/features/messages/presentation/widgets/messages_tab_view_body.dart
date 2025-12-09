import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/shared/presentation/views/widgets/messages_card.dart';
import 'package:taskly/features/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_view_model.dart';
import 'package:taskly/features/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_states.dart';
import '../../../welcome/presentation/cubit/welcome_states.dart';
import '../../domain/entities/message_entity.dart';
import '../manager/get_conversations_view_model/get_conversations_states.dart';
import '../manager/get_conversations_view_model/get_conversations_view_model.dart';
import '../manager/messages_view_model/messages_view_model.dart';
import '../manager/messages_view_model/messages_view_model_states.dart';
import '../manager/unread_messages_badge_view_model/unread_badge_states.dart';
import '../manager/unread_messages_badge_view_model/unread_messages_badge_view_model.dart';

class UserMessagesTabViewBody extends StatefulWidget {
  const UserMessagesTabViewBody({super.key});

  @override
  State<UserMessagesTabViewBody> createState() => _UserMessagesTabViewBodyState();
}

class _UserMessagesTabViewBodyState extends State<UserMessagesTabViewBody> {
  late final GetAcceptedOrderMessageViewModel orderVM;
  late final GetConversationsViewModel convVM;
  late final UserRole userRole;
  final messagesVM = getIt<MessagesViewModel>();
  final unreadVM = getIt<UnreadMessagesBadgeViewModel>();
  final currentUserId = SharedPrefHelper.getString(StringsManager.idKey)!;
  bool _subscriptionsInitialized = false;

  @override
  void initState() {
    super.initState();

    userRole = SharedPrefHelper.getString(StringsManager.roleKey) == 'freelancer'
        ? UserRole.freelancer
        : UserRole.client;

    orderVM = getIt<GetAcceptedOrderMessageViewModel>();
    convVM = getIt<GetConversationsViewModel>();

    _loadData();
  }

  Future<void> _loadData() async {
    await orderVM.getAcceptedOrderMessages(currentUserId, role: userRole);
    await convVM.getConversations(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAcceptedOrderMessageViewModel, GetAcceptedOrderMessageStates>(
      bloc: orderVM,
      listener: (context, state) {
        if (!_subscriptionsInitialized && state is GetAcceptedOrderMessageStatesSuccess) {
          _subscriptionsInitialized = true;
          for (var order in state.orders) {
            final otherUserId = userRole == UserRole.client
                ? order.freelancerId!
                : order.clientId!;
            messagesVM.loadAndSubscribeMessages(order.id, currentUserId, otherUserId);
            unreadVM.start(order.id, currentUserId, otherUserId);
          }
        }
      },
      child: RefreshIndicator(
        onRefresh: _loadData, // ✅ هنا الريفريش الحقيقي
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BlocBuilder<GetAcceptedOrderMessageViewModel, GetAcceptedOrderMessageStates>(
                  bloc: orderVM,
                  builder: (context, orderState) {
                    return BlocBuilder<GetConversationsViewModel, GetConversationsStates>(
                      bloc: convVM,
                      builder: (context, convState) {
                        if (convState is GetConversationsErrorStates) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/lotties/no_internet.json',
                                    width: 200, height: 200),
                                const SizedBox(height: 20),
                                const Text("تحقق من اتصالك بالإنترنت"),
                              ],
                            ),
                          );
                        }

                        final hasOrders = orderState is GetAcceptedOrderMessageStatesSuccess &&
                            orderState.orders.isNotEmpty;
                        final hasConversations = convState is GetConversationsSuccessStates &&
                            convState.conversationsList.isNotEmpty;

                        if (!hasOrders && !hasConversations) {
                          return   Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Column(
                                children: [
                                  Lottie.asset("assets/lotties/empty.json",height: 200.h,width: 200.w,),
                                  SizedBox(height: 20.h,),
                                  Text("لا توجد رسائل حالياً"),
                                ],
                              ),
                            ),
                          );
                        }

                        return BlocBuilder<MessagesViewModel, MessagesStates>(
                          bloc: messagesVM,
                          builder: (context, msgState) {
                            final messages = msgState is MessagesSuccess
                                ? msgState.messages
                                : <MessageEntity>[];

                            return Column(
                              children: [
                                if (hasOrders)
                                  ...orderState.orders.map((order) {
                                    final chatUserId = userRole == UserRole.client
                                        ? order.freelancerId
                                        : order.clientId;
                                    final chatUserRole = userRole == UserRole.client
                                        ? UserRole.freelancer
                                        : UserRole.client;

                                    return BlocBuilder<UnreadMessagesBadgeViewModel,
                                        UnreadMessagesBadgeState>(
                                      bloc: unreadVM,
                                      builder: (context, state) {
                                        final unreadCount =
                                        unreadVM.getUnreadCount(order.id);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: MessagesCard(
                                            unreadCount: unreadCount,
                                            chatUserId: chatUserId!,
                                            chatUserRole: chatUserRole,
                                            order: order,
                                            lastMessage: order.lastMessage ?? "....",
                                            lastMessageTime: DateTime.now(),
                                            onTap: () {},
                                            onUserInfoLoaded:
                                                (fullName, avatarUrl) async {
                                              await Navigator.pushNamed(
                                                context,
                                                RoutesManager.chatView,
                                                arguments: {
                                                  "currentUserName": SharedPrefHelper
                                                      .getString(StringsManager.fullNameKey),
                                                  "receiverName": fullName,
                                                  "currentUserAvatar": SharedPrefHelper
                                                      .getString(StringsManager.profileImageKey),
                                                  "receiverAvatar": avatarUrl,
                                                  "order": order,
                                                  "currentUserId": currentUserId,
                                                  "receiverId": chatUserId,
                                                },
                                              );
                                              unreadVM.markAsRead(order.id);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                if (hasConversations)
                                  ...convState.conversationsList.map((conversation) {
                                    final orderAlreadyExists = hasOrders &&
                                        orderState.orders
                                            .any((o) => o.id == conversation.order?.id);
                                    if (orderAlreadyExists) return const SizedBox.shrink();

                                    final user = conversation.user;
                                    return BlocBuilder<UnreadMessagesBadgeViewModel,
                                        UnreadMessagesBadgeState>(
                                      bloc: unreadVM,
                                      builder: (context, state) {
                                        final unreadCount =
                                        unreadVM.getUnreadCount(conversation.orderId!);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: MessagesCard(
                                            unreadCount: unreadCount,
                                            chatUserId: user.id,
                                            chatUserRole: user.role == "client"
                                                ? UserRole.client
                                                : UserRole.freelancer,
                                            order: conversation.order!,
                                            lastMessage:
                                            conversation.lastMessage ?? "....",
                                            lastMessageTime:
                                            conversation.lastMessageTime ??
                                                DateTime.now(),
                                            onTap: () {},
                                            onUserInfoLoaded:
                                                (fullName, avatarUrl) async {
                                              await Navigator.pushNamed(
                                                context,
                                                RoutesManager.chatView,
                                                arguments: {
                                                  "currentUserName": SharedPrefHelper
                                                      .getString(StringsManager.fullNameKey),
                                                  "receiverName": fullName,
                                                  "currentUserAvatar": SharedPrefHelper
                                                      .getString(StringsManager.profileImageKey),
                                                  "receiverAvatar": avatarUrl,
                                                  "order": conversation.order,
                                                  "currentUserId": currentUserId,
                                                  "receiverId": user.id,
                                                },
                                              );
                                              unreadVM.markAsRead(conversation.orderId!);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
