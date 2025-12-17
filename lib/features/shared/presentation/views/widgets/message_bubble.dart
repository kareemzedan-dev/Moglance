import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../reviews/presentation/widgets/user_avatar.dart';

enum SenderType { client, freelancer, admin }

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final SenderType sender;
  final String avatarUrl;
  final bool chatWithUsers;
  final String userName;
  final bool isSent;
  final DateTime? seenAt;

  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.sender,
    required this.avatarUrl,
    this.chatWithUsers = false,
    required this.userName,
    required this.isSent,
    this.seenAt,
  });

  @override
  Widget build(BuildContext context) {
    final isClient = sender == SenderType.client;

    Color bubbleColor = isClient ? Colors.grey.shade300 : ColorsManager.primary;

    IconData statusIcon = Icons.check;
    Color iconColor = Colors.white;

    if (!isClient && isSent && seenAt != null) {

      statusIcon = Icons.done_all;
      iconColor = Colors.green ;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
        isClient ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isClient) ...[
            UserAvatar(imagePath: avatarUrl, radius: 16.r, userName: userName),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(isClient ? 0 : 16.r),
                  bottomRight: Radius.circular(isClient ? 16.r : 0),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                isClient ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isClient ? ColorsManager.black : Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color: isClient ? Colors.black : Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      if (!isClient && isSent)
                        Icon(
                          statusIcon,
                          color: iconColor,
                          size: 12.sp,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isClient) ...[
            SizedBox(width: 8.w),
            UserAvatar(imagePath: avatarUrl, radius: 16.r, userName: userName),
          ],
        ],
      ),
    );
  }
}
