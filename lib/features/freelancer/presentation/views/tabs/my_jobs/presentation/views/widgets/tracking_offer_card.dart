import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart';
import 'package:taskly/features/profile/presentation/widgets/user_info_section.dart';
import 'package:taskly/features/client/presentation/views/tabs/profile/presentation/views/widgets/user_info_section_shimmer.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/freelancer/presentation/cubit/withdraw_offer_view_model/withdraw_offer_states.dart';
import 'package:taskly/features/freelancer/presentation/cubit/withdraw_offer_view_model/withdraw_offer_view_model.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../../core/helper/convert_to_days.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../../../../messages/presentation/widgets/admin_message_card.dart';
import '../../../../../../../../profile/presentation/manager/profile_view_model/profile_view_model.dart';
import '../../../../../../../../profile/presentation/manager/profile_view_model/profile_view_model_states.dart';
import '../../../../find_work/presentation/views/widgets/action_row.dart';
import '../../../../find_work/presentation/views/widgets/delivery_info.dart';

class TrackingOfferCard extends StatelessWidget {
  TrackingOfferCard({
    super.key,
    required this.offerEntity,
    this.isPending = false,
    this.isAccepted = false,
    this.isRejected = false,
    this.isCompleted = false,

  });

  OfferEntity offerEntity;
  bool isPending;
  bool isAccepted;
  bool isRejected;
  bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor ,
          border: Border.all(color: Colors.grey.shade300, width: 2.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isAccepted)
                  AdminMessageCard(
                  message: local.checkOrderStatusMessage,
                ),

              SizedBox(height: 5.h),
              BlocBuilder<ProfileViewModel, ProfileViewModelStates>(
                bloc: getIt<ProfileViewModel>()
                  ..getUserInfo(offerEntity.clientId, "client"),
                builder: (context, state) {
                  if (state is ProfileViewModelStatesLoading) {
                    return const UserInfoSectionShimmer();
                  }
                  if (state is ProfileViewModelStatesError) {
                    return const UserInfoSectionShimmer();
                  }
                  if (state is ProfileViewModelStatesSuccess) {
                    return UserInfoSection(
                      photoSizeSelected: true,
                      name: state.userInfoEntity.fullName,
                      email: state.userInfoEntity.email,
                      rating: state.userInfoEntity.rating!,
                      userInfo: state.userInfoEntity,
                    );
                  }
                  return   Center(child: Text(local.loading));
                },
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      offerEntity.orderName!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: ColorsManager.primary.withOpacity(0.1),
                      border: Border.all(
                          color: ColorsManager.primary.withOpacity(0.1),
                          width: 1.w),
                    ),
                    child: Text(
                      offerEntity.offerStatus,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: ColorsManager.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                "${local.proposal_description}:${offerEntity.offerDescription} ",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              if (!isRejected && !isCompleted)
                DeliveryInfo(
                  deliveryTime: offerEntity.offerDeliveryTime.formatMinutes(context),
                ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.attach_money_outlined, size: 15.sp),
                  Text(
                    "${offerEntity.offerAmount} ${local.sar}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              if (isRejected)
                GestureDetector(
                  onTap: () {
                    context.read<UpdateOfferStatusViewModel>()
                      .updateOfferStatus(offerEntity.id, "deleted");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Theme.of(context).scaffoldBackgroundColor ,
                      border: Border.all(color: Colors.red, width: 2.w),
                    ),
                    child:   Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.close,
                            color: Colors.red,
                          ),
                          SizedBox(width: 6),
                          Text(
                            local.delete_this_offer,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              BlocBuilder<WithdrawOfferViewModel, WithdrawOfferStates>(
                builder: (context, state) {
                  return ActionsRow(
                    actions: [
                      if (!isRejected)
                        ActionItem(
                          title: local.viewDetails,
                          icon: Icons.remove_red_eye_outlined,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.offerDetailsView,
                              arguments: {
                                'orderId': offerEntity.orderId,
                              },
                            );
                          },
                        ),
                      if (isPending)
                        ActionItem(
                          title: state is WithdrawOfferStatesLoading
                              ?  local.withdrawing
                              : local.withdraw_offer,
                          icon: Icons.remove_circle_outline,
                          isOffer: true,
                          onTap: state is WithdrawOfferStatesLoading
                              ? null
                              : () {
                                  context
                                      .read<WithdrawOfferViewModel>()
                                      .withdrawOffer(
                                          offerEntity.id, offerEntity.orderId);
                                },
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
