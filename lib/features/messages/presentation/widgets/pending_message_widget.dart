// widgets/pending_message_widget.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';
import '../../data/models/pending_message_model/pending_message_model.dart';
import 'chat_messages_list.dart';

class PendingMessageWidget extends StatelessWidget {
  final PendingMessage pendingMessage;
  final String avatarUrl;
  final String userName;

  const PendingMessageWidget({
    super.key,
    required this.pendingMessage,
    required this.avatarUrl,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: pendingMessage.isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!pendingMessage.isCurrentUser) ...[
            UserAvatar(imagePath: avatarUrl, radius: 16.r, userName: userName),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              child: _buildMessageContent(context),
            ),
          ),
          if (pendingMessage.isCurrentUser) ...[
            SizedBox(width: 8.w),
            UserAvatar(imagePath: avatarUrl, radius: 16.r, userName: userName),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    switch (pendingMessage.type) {
      case MessagesType.text:
        return _buildPendingTextMessage(context);

      case MessagesType.audio:
        return _buildPendingVoiceMessage(context);

      case MessagesType.file:
        if (_isImageFile(pendingMessage.filePath)) {
          return _buildPendingImageMessage(context);
        } else {
          return _buildPendingFileMessage(context);
        }

      default:
        return _buildPendingTextMessage(context);
    }
  }

  Widget _buildPendingTextMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: pendingMessage.isCurrentUser ? ColorsManager.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(pendingMessage.isCurrentUser ? 16.r : 0),
          bottomRight: Radius.circular(pendingMessage.isCurrentUser ? 0 : 16.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16.r,
            height: 16.r,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                pendingMessage.isCurrentUser ? Colors.white : ColorsManager.primary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: pendingMessage.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  pendingMessage.content,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: pendingMessage.isCurrentUser ? ColorsManager.white : ColorsManager.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'جاري الإرسال...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: pendingMessage.isCurrentUser ? ColorsManager.white.withOpacity(0.8) : ColorsManager.black.withOpacity(0.6),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingImageMessage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pendingMessage.isCurrentUser ? ColorsManager.primary.withOpacity(0.1) : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(pendingMessage.isCurrentUser ? 16.r : 0),
          bottomRight: Radius.circular(pendingMessage.isCurrentUser ? 0 : 16.r),
        ),
        border: Border.all(
          color: pendingMessage.isCurrentUser ? ColorsManager.primary.withOpacity(0.3) : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: pendingMessage.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // الصورة المحلية
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: pendingMessage.caption != null ? Radius.zero : Radius.circular(pendingMessage.isCurrentUser ? 16.r : 0),
              bottomRight: pendingMessage.caption != null ? Radius.zero : Radius.circular(pendingMessage.isCurrentUser ? 0 : 16.r),
            ),
            child: Stack(
              children: [
                pendingMessage.filePath != null && File(pendingMessage.filePath!).existsSync()
                    ? Image.file(
                  File(pendingMessage.filePath!),
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                )
                    : Container(
                  height: 200.h,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.image, color: Colors.grey, size: 40.r),
                ),
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 14.r,
                          height: 14.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: pendingMessage.uploadProgress,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${(pendingMessage.uploadProgress * 100).toInt()}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // النص التوضيحي والتحميل
          if (pendingMessage.caption != null && pendingMessage.caption!.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              child: Text(
                pendingMessage.caption!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: pendingMessage.isCurrentUser ? ColorsManager.primary : ColorsManager.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPendingFileMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: pendingMessage.isCurrentUser ? ColorsManager.primary.withOpacity(0.1) : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(pendingMessage.isCurrentUser ? 16.r : 0),
          bottomRight: Radius.circular(pendingMessage.isCurrentUser ? 0 : 16.r),
        ),
        border: Border.all(
          color: pendingMessage.isCurrentUser ? ColorsManager.primary.withOpacity(0.3) : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // أيقونة الملف
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.insert_drive_file, color: Colors.grey, size: 24.r),
          ),
          SizedBox(width: 12.w),

          // معلومات الملف والتقدم
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pendingMessage.content.isNotEmpty ? pendingMessage.content : 'ملف',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: pendingMessage.isCurrentUser ? ColorsManager.primary : ColorsManager.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 6.h),
                LinearProgressIndicator(
                  value: pendingMessage.uploadProgress,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    pendingMessage.isCurrentUser ? ColorsManager.primary : Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'جاري الرفع...',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: pendingMessage.isCurrentUser ? ColorsManager.primary.withOpacity(0.6) : ColorsManager.black.withOpacity(0.6),
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '${(pendingMessage.uploadProgress * 100).toInt()}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: pendingMessage.isCurrentUser ? ColorsManager.primary : ColorsManager.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingVoiceMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: pendingMessage.isCurrentUser ? ColorsManager.primary : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(pendingMessage.isCurrentUser ? 16.r : 0),
          bottomRight: Radius.circular(pendingMessage.isCurrentUser ? 0 : 16.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // زر التشغيل مع المؤشر
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: pendingMessage.isCurrentUser ? Colors.white.withOpacity(0.2) : ColorsManager.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 20.r,
              height: 20.r,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  pendingMessage.isCurrentUser ? Colors.white : ColorsManager.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // شريط التقدم والنص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'جاري رفع الرسالة الصوتية...',
                  style: TextStyle(
                    color: pendingMessage.isCurrentUser ? Colors.white : ColorsManager.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                LinearProgressIndicator(
                  value: pendingMessage.uploadProgress,
                  backgroundColor: pendingMessage.isCurrentUser ? Colors.white.withOpacity(0.3) : Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    pendingMessage.isCurrentUser ? Colors.white : ColorsManager.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '${(pendingMessage.uploadProgress * 100).toInt()}%',
            style: TextStyle(
              color: pendingMessage.isCurrentUser ? Colors.white.withOpacity(0.8) : ColorsManager.black.withOpacity(0.6),
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  bool _isImageFile(String? filePath) {
    if (filePath == null) return false;
    final path = filePath.toLowerCase();
    return path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.gif');
  }
}