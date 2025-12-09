// widgets/file_message_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

class FileMessageWidget extends StatelessWidget {
  final String fileUrl;
  final String time;
  final bool isCurrentUser;
  final String avatarUrl;
  final String userName;

  const FileMessageWidget({
    super.key,
    required this.fileUrl,
    required this.time,
    required this.isCurrentUser,
    required this.avatarUrl,
    required this.userName,
  });

  String get fileName => fileUrl.split('/').last;
  String get fileExtension => fileName.split('.').last.toLowerCase();

  IconData get fileIcon {
    switch (fileExtension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'zip':
      case 'rar':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color get fileColor {
    switch (fileExtension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      case 'zip':
      case 'rar':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> _downloadAndOpenFile(BuildContext context) async {
    try {
      // عرض مؤشر التحميل
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(width: 12.w),
              Text('جاري تحميل الملف...'),
            ],
          ),
          backgroundColor: ColorsManager.primary,
        ),
      );

      final fileName = fileUrl.split('/').last;
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      if (!await file.exists()) {
        final bytes = (await NetworkAssetBundle(Uri.parse(fileUrl)).load(fileUrl)).buffer.asUint8List();
        await file.writeAsBytes(bytes);
      }

      // إخفاء المؤشر
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      await OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل في فتح الملف'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
            child: GestureDetector(
              onTap: () => _downloadAndOpenFile(context),
              child: Container(
                padding: EdgeInsets.all(12.w),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: fileColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(fileIcon, color: fileColor, size: 24.r),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fileName,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isCurrentUser ? ColorsManager.primary : ColorsManager.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${fileExtension.toUpperCase()} ملف',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isCurrentUser ? ColorsManager.primary.withOpacity(0.6) : ColorsManager.black.withOpacity(0.6),
                              fontSize: 12.sp,
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
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.download,
                      color: isCurrentUser ? ColorsManager.primary : Colors.grey.shade600,
                      size: 20.r,
                    ),
                  ],
                ),
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