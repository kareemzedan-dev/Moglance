import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/messages/presentation/manager/subscribe_to_unread_messages_view_model/subscribe_to_unread_messages_view_model.dart';
import 'package:taskly/features/messages/presentation/manager/subscribe_to_unread_messages_view_model/subscribe_to_unread_messages_view_model_states.dart';
import '../../config/l10n/app_localizations.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.firstTabName,
    this.firstTabicon,
    this.hasJobUpdates = false,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final String? firstTabName;
  final String? firstTabicon;


  final bool hasJobUpdates;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocBuilder<SubscribeToUnreadMessagesViewModel,
        SubscribeToUnreadMessagesViewModelStates>(
      builder: (context, state) {
        bool hasUnread = false;

        if (state is SubscribeToUnreadMessagesViewModelStatesSuccess) {
          hasUnread = state.messages.any((m) => m.seenAt == null);
        }

        return BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: ColorsManager.primary,
          unselectedItemColor: Theme.of(context).textTheme.bodyLarge?.color,
          items: [
            // ---------------- Home ----------------
            BottomNavigationBarItem(
              icon: Image.asset(
                firstTabicon ?? Assets.assetsImagesHome4561540,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                height: 24.h,
                width: 24.w,
              ),
              activeIcon: Image.asset(
                firstTabicon ?? Assets.assetsImagesHome4561540,
                color: ColorsManager.primary,
                height: 24.h,
                width: 24.w,
              ),
              label: firstTabName ?? local.home,
            ),

            // ---------------- My Jobs (مع البادج الجديد) ----------------
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    Assets.assetsImagesJobBoard18989826,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    height: 24.h,
                    width: 24.w,
                  ),
                  if (hasJobUpdates)   // 🔥 هنا البادج
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    Assets.assetsImagesJobBoard18989826,
                    color: ColorsManager.primary,
                    height: 24.h,
                    width: 24.w,
                  ),
                  if (hasJobUpdates)
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              label: local.my_jobs,
            ),

            // ---------------- Messages ----------------
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    Assets.assetsImagesChat6431892,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    height: 24.h,
                    width: 24.w,
                  ),
                  if (hasUnread)
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    Assets.assetsImagesChat6431892,
                    color: ColorsManager.primary,
                    height: 24.h,
                    width: 24.w,
                  ),
                  if (hasUnread)
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              label: local.messages,
            ),

            // ---------------- Profile ----------------
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.assetsImagesUser12366536,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                height: 24.h,
                width: 24.w,
              ),
              activeIcon: Image.asset(
                Assets.assetsImagesUser12366536,
                color: ColorsManager.primary,
                height: 24.h,
                width: 24.w,
              ),
              label: local.profile,
            ),
          ],
        );
      },
    );
  }
}
