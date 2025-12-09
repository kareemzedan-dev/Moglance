import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/app_text_styles.dart';
import 'package:taskly/features/profile/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/utils/strings_manager.dart';

class UserInfoSection extends StatelessWidget {
  final String? name, email;
  final double ? rating;
  final bool isFreelancer;
  final bool photoSizeSelected;
  final bool emailShow;
  final VoidCallback? onTap;
  final UserInfoEntity? userInfo;

  const UserInfoSection({
    super.key,
    this.name,
    this.email,
     this.rating   ,
    this.isFreelancer = false,
    this.photoSizeSelected = false,
    this.emailShow = true,
    this.onTap,
    this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = SharedPrefHelper.getString(StringsManager.fullNameKey)!;
    final displayEmail =  SharedPrefHelper.getString(StringsManager.emailKey)!;
    final profileImage = SharedPrefHelper.getString(StringsManager.profileImageKey);
    final displayRating = double.tryParse(
        SharedPrefHelper.getString(StringsManager.ratingKey) ?? "0.0"
    ) ?? 0.0;


    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
         UserAvatar(
           userName: displayName,
            imagePath:profileImage,
            radius:   30.r  ,
          ),
          SizedBox(width: 20.w),
          Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,

            ),
            maxLines: 1,  
            overflow: TextOverflow.ellipsis,
          ),
          if (emailShow)
            Text(
              displayEmail,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              maxLines: 1,  
              overflow: TextOverflow.ellipsis,
            ),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < displayRating.round()
                          ? CupertinoIcons.star_fill
                          : CupertinoIcons.star,
                      color: Colors.amber,
                      size: 14.sp,
                    );
                  }),
                  SizedBox(width: 10.w),
                  Text(
                    displayRating.toStringAsFixed(1),
                    style: AppTextStyles.bold16.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              if (isFreelancer)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Colors.green,
                      size: 14.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Verified Freelancer',
                      style: AppTextStyles.bold14.copyWith(color: Colors.grey),
                    ),
                  ],
      ),
            ],
             )   ),
        ],
      ),
    );
  }
}
