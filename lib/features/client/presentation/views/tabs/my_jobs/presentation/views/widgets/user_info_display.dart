import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/app_text_styles.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';

class UserInfoDisplay extends StatelessWidget {
  final String name;
  final String email;
  final double rating;
  final String? profileImage;
  final bool isFreelancer;
  final bool emailShow;
  final VoidCallback? onTap;

  const UserInfoDisplay({
    super.key,
    required this.name,
    required this.email,
    this.rating = 0.0,
    this.profileImage,
    this.isFreelancer = false,
    this.emailShow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          UserAvatar(
            userName: name,
            imagePath: profileImage,
            radius: 30.r,
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (emailShow)
                  Text(
                    email,
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
                        index < rating.round()
                            ? CupertinoIcons.star_fill
                            : CupertinoIcons.star,
                        color: Colors.amber,
                        size: 14.sp,
                      );
                    }),
                    SizedBox(width: 10.w),
                    Text(
                      rating.toStringAsFixed(1),
                      style: AppTextStyles.bold16.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      isFreelancer
                          ? Icons.verified_user_outlined
                          : null,
                      color: isFreelancer ? Colors.green : Colors.red,
                      size: 14.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      isFreelancer ? local.verifiedFreelancer :"",
                      style: AppTextStyles.bold14.copyWith(
                        color: isFreelancer ? Colors.grey : Colors.red,
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
}
