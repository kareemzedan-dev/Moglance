import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_offers_view_model/get_offers_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_offers_view_model/get_offers_view_model_states.dart';
import 'package:taskly/features/payments/presentation/manager/get_payment_view_model/get_payment_view_model.dart';
import 'package:taskly/features/payments/presentation/manager/get_payment_view_model/get_payment_view_model_states.dart';
import 'package:taskly/features/payments/presentation/widgets/payment_status_bottom_sheet.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/offers_model_bottom_sheet_content.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/order_action_button.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/order_details_bottom_sheet_content.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/order_header.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/order_progress_time_line.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../../core/cache/shared_preferences.dart';
import '../../../../../../../../../core/utils/strings_manager.dart';
import '../../../../../../../../profile/presentation/manager/profile_view_model/profile_view_model.dart';
import '../../view_model/update_offer_status_view_model/update_offer_status_view_model.dart';

int getStep(OrderStatus status) {
  switch (status) {
    case OrderStatus.Pending:
    case OrderStatus.Accepted:
      return 0;
    case OrderStatus.Paid:
      return 1;
    case OrderStatus.InProgress:
      return 2;
    case OrderStatus.Completed:
      return 3;
    case OrderStatus.Cancelled:
      return 3;
    default:
      return 0;
  }
}

class OrderStatesCard extends StatelessWidget {
  const OrderStatesCard({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    print(
      '🎨 Building OrderStatesCard for: ${order.id} - Status: ${order.status}',
    );

    final local = AppLocalizations.of(context)!;
    return BlocProvider<GetOffersViewModel>(
      create: (_) => getIt<GetOffersViewModel>()..init(order.id),
      child: Card(
        elevation: 10,

        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).scaffoldBackgroundColor,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderHeader(
                  orderName: order.title,
                  orderId: order.id,
                  orderStatus: order.status.name,
                ),
                SizedBox(height: 20.h),
                OrderProgressTimeline(
                  steps: [
                    local.created,
                    local.paid,
                    local.inProgress,
                    order.status.name == OrderStatus.Cancelled.name
                        ? local.cancelled
                        : local.completed,
                  ],
                  currentStep: getStep(order.status),
                ),
                SizedBox(height: 26.h),
                BlocBuilder<GetOffersViewModel, GetOffersViewModelStates>(
                  builder: (context, state) {
                    int count = 0;
                    if (state is GetOffersViewModelSuccess) {
                      count = state.offersCount;
                    }

                    if (order.status == OrderStatus.Pending) {
                      return OrderActionButton(
                        text: local.offersReceived,
                        icon: Icons.local_offer_outlined,
                        color: ColorsManager.primary,
                        count: count,
                        onTap: () {
                          final viewModel = context.read<GetOffersViewModel>();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (ctx) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(value: viewModel),
                                BlocProvider(
                                  create: (_) =>
                                      getIt<UpdateOfferStatusViewModel>(),
                                ),
                              ],
                              child: OffersBottomSheetContent(
                                orderId: order.id,
                                order: order,
                              ),
                            ),
                          );
                        },
                      );
                    } else if (order.status == OrderStatus.Accepted) {
                      return OrderActionButton(
                        text: local.paid_now(order.budget.toString()),
                        icon: Icons.money,
                        color: ColorsManager.primary,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.clientPaymentsView,
                            arguments: {'orderEntity': order},
                          );
                        },
                      );
                    } else if (order.status == OrderStatus.Paid) {
                      return CustomButton(
                        title: local.payment_under_review,
                        ontap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BlocBuilder<
                                GetPaymentViewModel,
                                GetPaymentViewModelStates
                              >(
                                bloc: getIt<GetPaymentViewModel>()
                                  ..getPayment(order.id),
                                builder: (context, state) {
                                  if (state is GetPaymentViewModelLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is GetPaymentViewModelError) {
                                    return Center(child: Text(state.message));
                                  }
                                  if (state is GetPaymentViewModelSuccess) {
                                    return PaymentStatusBottomSheet(
                                      payment: state.payments,
                                    );
                                  }
                                  return Container();
                                },
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: OrderActionButton(
                        text: local.viewDetails,
                        icon: Icons.remove_red_eye_outlined,
                        color: ColorsManager.primary,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return OrderDetailsBottomSheetContent(
                                order: order,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: OrderActionButton(
                        text:order.status.name == OrderStatus.Pending.name||order.status.name == OrderStatus.Paid.name||order.status.name == OrderStatus.Accepted.name ? local.chat_with_admin : local.chat_with_freelancer,
                        icon: Icons.chat,
                        color: ColorsManager.primary,
                        onTap: ()async {
                          if(order.status.name == OrderStatus.Pending.name||order.status.name == OrderStatus.Paid.name||order.status.name == OrderStatus.Accepted.name){
                            Navigator.pushNamed(
                              context,
                              RoutesManager.adminChatView,
                              arguments: {
                                "currentUserId": SharedPrefHelper.getString(
                                  StringsManager.idKey,
                                ),
                              },
                            );
                          }
                          else {
                            final profileVM = getIt<ProfileViewModel>();
                            final receiver = await profileVM.getUserInfoFuture(order.freelancerId!, "freelancer");

                            Navigator.pushNamed(
                              context,
                              RoutesManager.chatView,
                              arguments: {
                                "currentUserName": SharedPrefHelper.getString(StringsManager.fullNameKey),
                                "receiverName": receiver.fullName ?? "",
                                "currentUserAvatar": SharedPrefHelper.getString(StringsManager.profileImageKey),
                                "receiverAvatar": receiver.profileImage ?? "",
                                "order": order,
                                "currentUserId":order.clientId  ,
                                "receiverId": order.freelancerId,
                              },
                            );
                          }


                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
