// chat/presentation/widgets/chat_header_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/components/confirmation_dialog.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/components/dismissible_error_card.dart';
import 'package:taskly/core/services/notification_service.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart';
import 'package:taskly/features/freelancer/presentation/cubit/add_earnings_view_model/add_earnings_view_model.dart';
import 'package:taskly/features/freelancer/presentation/cubit/update_order_status_view_model/update_order_status_view_model.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';
import 'package:taskly/features/reviews/presentation/manager/get_user_reviews_view_model/get_user_reviews_states.dart';
import 'package:taskly/features/reviews/presentation/manager/get_user_reviews_view_model/get_user_reviews_view_model.dart';
import 'package:taskly/features/reviews/presentation/widgets/rating_bottom_sheet.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/shared/presentation/manager/subscribe_to_order_record_view_model/subscribe_to_order_record_view_model.dart';
import 'package:taskly/features/messages/presentation/widgets/admin_message_card.dart';
import 'package:taskly/core/di/di.dart';
import '../../../../config/l10n/app_localizations.dart';
import '../../../profile/presentation/manager/profile_view_model/profile_view_model_states.dart';
import '../../../reviews/presentation/manager/submit_rating_view_model/submit_rating_view_model.dart';
import '../../../shared/presentation/manager/subscribe_to_order_record_view_model/subscribe_to_order_record_states.dart';
import 'order_status_card.dart';

class ChatHeaderSection extends StatelessWidget {
  final OrderEntity order;
  final String currentUserId;

  const ChatHeaderSection({
    super.key,
    required this.order,
    required this.currentUserId,
  });

  void _showRatingBottomSheet(BuildContext context, OrderEntity order) async {
    final targetId =
    currentUserId == order.clientId ? order.freelancerId! : order.clientId;

    final role =
    currentUserId == order.clientId ? "freelancer" : "client";

    // 🔥 هات البيانات مرة واحدة قبل فتح الشيت
    final profileVM = getIt<ProfileViewModel>();
    await profileVM.getUserInfo(targetId, role);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => getIt<SubmitRatingViewModel>(),
        child: BlocBuilder<ProfileViewModel, ProfileViewModelStates>(
          bloc: profileVM,
          builder: (context, state) {
            if (state is ProfileViewModelStatesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileViewModelStatesSuccess) {
              return RatingBottomSheet(
                order: order,
                currentUserId: currentUserId,
                receiverId: targetId,
                userName: state.userInfoEntity.fullName ?? "",
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocBuilder<SubscribeOrdersRecordViewModel, OrderViewModelState>(
      builder: (context, state) {
        final orderData = state is OrderSuccess ? state.order : order;
        final viewModel = context.read<SubscribeOrdersRecordViewModel>();
        final adminMessage = viewModel.getAdminMessage(orderData, local);
        final buttonText =
            viewModel.getActionButtonText(orderData, currentUserId, local);

        // Button for freelancer to rate client (only visible to freelancer when order completed)
        final freelancerRatingButton = orderData.status.name == "Completed" &&
            currentUserId == order.freelancerId;
        final clientRatingButton = orderData.status.name == "Completed" &&
            currentUserId == order.clientId;

        return Column(
          children: [
            OrderStatusCard(
              price: orderData.budget ?? 0,
              status: orderData.status.name,
              message: "",
              buttonText: buttonText,
              onButtonPressed: buttonText != null
                  ? () {
                      if (buttonText ==
                          local.payNowButton(orderData.budget.toString())) {
                        Navigator.pushNamed(
                          context,
                          RoutesManager.clientPaymentsView,
                          arguments: {'orderEntity': orderData},
                        );
                      } else if (buttonText == local.submitDeliveryButton) {
                        showConfirmationDialog(
                          context: context,
                          title: local.submitDeliveryButton,
                          message: local.submitDeliveryConfirmation,
                          onConfirm: () {
                            context
                                .read<UpdateOrderStatusViewModel>()
                                .updateOrderStatus(orderData.id, "Waiting");
                            NotificationService().sendNotification(
                              receiverId: orderData.clientId,
                              title: "تحديث حاله الطلب",
                              body:
                                  "تم تسليم العمل من جانب المستقل، من فضلك قم بمراجعه العمل وتأكيد الاستلام",
                            );
                          },
                          onCancel: () {},
                        );
                      } else if (buttonText == local.workReceivedButton) {
                        showConfirmationDialog(
                          context: context,
                          title: local.workReceivedButton,
                          message: local.workReceivedConfirmation,
                          onConfirm: () {
                            context.read<UpdateOfferStatusViewModel>()
                              ..updateOfferStatus(
                                  orderData.offerId!, "Completed");
                            context
                                .read<UpdateOrderStatusViewModel>()
                                .updateOrderStatus(orderData.id, "Completed");

                            final formattedPrice = double.parse(
                                orderData.budget!.toStringAsFixed(2));
                            context.read<AddEarningsViewModel>().addEarnings(
                                  orderData.freelancerId!,
                                  formattedPrice,
                                  orderData.clientId,
                                );

                            // after marking completed show rating sheet for freelancer
                            _showRatingBottomSheet(context, orderData);

                            NotificationService().sendNotification(
                              receiverId: orderData.freelancerId!,
                              title: "تم إضافة رصيد إلى حسابك 💰",
                              body:
                                  "تم إضافة المبلغ الخاص بطلب «${orderData.title}» إلى رصيدك بنجاح.",
                            );
                          },
                        );
                      }
                    }
                  : null,
            ),
             if(buttonText == local.rateFreelancer || buttonText == local.rateClient)
            BlocBuilder<GetUserReviewsViewModel, GetUserReviewsStates>(
              builder: (context, reviewState) {
                if (reviewState is GetUserReviewsLoading) {
                  return const SizedBox.shrink();
                }

                if (reviewState is GetUserReviewsSuccess) {
                  final hasRated = reviewState.reviewsList.any((r) {
                    final reviewerId =
                        r.role == "client" ? r.clientId : r.freelancerId;
                    return r.orderId == orderData.id &&
                        reviewerId == currentUserId;
                  });

                  if (hasRated)
                    return const SizedBox
                        .shrink();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      title: currentUserId == orderData.clientId
                          ? local.rateFreelancer
                          : local.rateClient,
                      ontap: () async {
                        _showRatingBottomSheet(context, orderData);

                        // بعد ما يضيف التقييم، نعمل reload للـ reviews
                        context.read<GetUserReviewsViewModel>().getUserReviews(
                              currentUserId == orderData.clientId
                                  ? orderData.freelancerId!
                                  : orderData.clientId,
                              currentUserId == orderData.clientId
                                  ? "freelancer"
                                  : "client",
                            );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            // A dedicated button shown to freelancer (when order completed) to rate the client (if not already rated by this freelancer)
            // if (freelancerRatingButton)
            //   BlocBuilder<GetUserReviewsViewModel, GetUserReviewsStates>(
            //     builder: (context, reviewState) {
            //       if (reviewState is GetUserReviewsLoading) {
            //         return const SizedBox.shrink(); // hide while loading
            //       }
            //
            //       if (reviewState is GetUserReviewsSuccess) {
            //         final hasRated = reviewState.reviewsList.any(
            //               (r) {
            //             final reviewerId = r.role == "client" ? r.clientId : r.freelancerId;
            //             return r.orderId == orderData.id && reviewerId == currentUserId;
            //           },
            //         );
            //
            //
            //         if (hasRated) return const SizedBox.shrink(); // if this freelancer already rated this order, hide button
            //
            //         return Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: CustomButton(
            //             title: local.rateClient,
            //             ontap: () => _showRatingBottomSheet(context, orderData),
            //           ),
            //         );
            //       }
            //       return const SizedBox.shrink();
            //     },
            //   ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdminMessageCard(message: adminMessage),
            ),
          ],
        );
      },
    );
  }
}
