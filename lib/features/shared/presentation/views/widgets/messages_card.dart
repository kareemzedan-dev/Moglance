import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/client/presentation/views/tabs/profile/presentation/views/widgets/user_info_section_shimmer.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model_states.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';
import '../../../../../config/l10n/app_localizations.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/helper/get_localized_order_status.dart';
import '../../../../welcome/presentation/cubit/welcome_states.dart';
import '../../../domain/entities/order_entity/order_entity.dart';
class MessagesCard extends StatelessWidget {
  const MessagesCard({
    super.key,
    required this.onTap,
    required this.order,
    required this.chatUserId,
    required this.chatUserRole,
    required this.onUserInfoLoaded,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount, // ← عدد الرسائل غير المقروءة
  });

  final void Function(String fullName, String avatarUrl) onUserInfoLoaded;
  final VoidCallback onTap;
  final OrderEntity order;
  final String chatUserId;
  final UserRole chatUserRole;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount; // ← عدد الرسائل غير المقروءة

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) =>
      getIt<ProfileViewModel>()..getUserInfo(chatUserId, chatUserRole.name),
      child: BlocBuilder<ProfileViewModel, ProfileViewModelStates>(
        builder: (context, state) {
          if (state is ProfileViewModelStatesLoading ||
              state is ProfileViewModelStatesError) {
            return const UserInfoSectionShimmer();
          }
          if (state is ProfileViewModelStatesSuccess) {
            return GestureDetector(
              onTap: () {
                onUserInfoLoaded(
                  state.userInfoEntity.fullName ?? "Unknown",
                  state.userInfoEntity.profileImage ?? "",
                );
                onTap();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorsManager.primary.withAlpha(50),
                    width: 2.w,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar مع badge
                    Stack(
                      children: [
                        UserAvatar(
                          userName: state.userInfoEntity.fullName,
                          imagePath: state.userInfoEntity.profileImage,
                          radius: 30.r,
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5.w,
                                ),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18.w,
                                minHeight: 18.w,
                              ),
                              child: Center(
                                child: Text(
                                  unreadCount > 99 ? '99+' : '$unreadCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.userInfoEntity.fullName ?? "Unknown",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.message,
                                color: Colors.grey.shade400,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  lastMessage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 100.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorsManager.primary),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              getLocalizedStatus(local, order.status.name),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 100.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            height: 40.h,
                            child: Marquee(
                              text: order.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              blankSpace: 20.0,
                              velocity: 30.0,
                              pauseAfterRound: const Duration(seconds: 1),
                              startPadding: 10.0,
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration:
                              const Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
