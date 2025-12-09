// widgets/media_message_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

class MediaMessageWidget extends StatelessWidget {
  final String fileUrl;
  final String time;
  final bool isCurrentUser;
  final String avatarUrl;
  final String? caption;
  final String userName;

  const MediaMessageWidget({
    super.key,
    required this.fileUrl,
    required this.time,
    required this.isCurrentUser,
    required this.avatarUrl,
    this.caption,
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
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 0.65.sw),
            child: Container(
              decoration: BoxDecoration(
                color: isCurrentUser ? ColorsManager.primary.withOpacity(0.1) : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(isCurrentUser ? 16.r : 0),
                  bottomRight: Radius.circular(isCurrentUser ? 0 : 16.r),
                ),
                border: Border.all(
                  color: isCurrentUser ? ColorsManager.primary.withOpacity(0.3) : Colors.grey.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // الصورة
                  GestureDetector(
                    onTap: () => _showFullScreenImage(context, fileUrl),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomLeft: caption != null ? Radius.zero : Radius.circular(isCurrentUser ? 16.r : 0),
                        bottomRight: caption != null ? Radius.zero : Radius.circular(isCurrentUser ? 0 : 16.r),
                      ),
                      child: Image.network(
                        fileUrl,
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200.h,
                            color: Colors.grey.shade300,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200.h,
                          color: Colors.grey.shade300,
                          child: Icon(Icons.error, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  // النص التوضيحي (إن وجد)
                  if (caption != null && caption!.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(isCurrentUser ? 16.r : 0),
                          bottomRight: Radius.circular(isCurrentUser ? 0 : 16.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            caption!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isCurrentUser ? ColorsManager.primary : ColorsManager.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            time,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isCurrentUser ? ColorsManager.primary.withOpacity(0.6) : ColorsManager.black.withOpacity(0.6),
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // الوقت فقط إذا لم يكن هناك نص توضيحي
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        time,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isCurrentUser ? ColorsManager.primary.withOpacity(0.6) : ColorsManager.black.withOpacity(0.6),
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
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

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(imageUrl),
              backgroundDecoration: BoxDecoration(color: Colors.black87),
            ),
            Positioned(
              top: 40.h,
              right: 20.w,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30.r),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}