

  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

import '../../../../core/helper/format_last_seen.dart';
import '../../../shared/domain/entities/order_entity/order_entity.dart';
  AppBar customAppBar(
      BuildContext context, {
        required String userName,
        required String userImage,
        required OrderEntity order,
        required bool isOnline,
        required DateTime lastSeen,
          Function ? onBackButtonPressed,
      }) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 70.h,
      elevation: 0,
      shape: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 2),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.grey.shade500),
          onPressed: () {},
        ),
      ],
      leadingWidth: double.infinity,
      leading: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () =>onBackButtonPressed ?? Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey.shade500,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 8.w),
              UserAvatar(imagePath:userImage, radius: 20.r, userName: userName),
              SizedBox(width: 8.w),
              // Flexible for text responsiveness
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // User name
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        // Online indicator
                        if (isOnline)
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (isOnline)
                          SizedBox(width: 4.w), // مسافة بين الدائرة والنص
                        // Last seen or online text
                        Expanded(
                          child: Text(
                            formatLastSeen(isOnline: isOnline, lastSeen: lastSeen,context: context),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: isOnline ? Colors.green : Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      centerTitle: true,
    );
  }
