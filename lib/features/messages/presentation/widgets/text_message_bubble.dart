// widgets/text_message_bubble.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

class TextMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isCurrentUser;
  final String avatarUrl;
  final String userName;

  const TextMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isCurrentUser,
    required this.avatarUrl,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            UserAvatar(imagePath: avatarUrl, radius: 16.r, userName: userName),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: isCurrentUser ? ColorsManager.primary : Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(isCurrentUser ? 16.r : 0),
                  bottomRight: Radius.circular(isCurrentUser ? 0 : 16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isCurrentUser ? ColorsManager.white : ColorsManager.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isCurrentUser ? ColorsManager.white.withOpacity(0.8) : ColorsManager.black.withOpacity(0.6),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isCurrentUser) ...[
            SizedBox(width: 8.w),
            UserAvatar(imagePath: avatarUrl, radius: 16.r, userName: userName),
          ],
        ],
      ),
    );
  }
}