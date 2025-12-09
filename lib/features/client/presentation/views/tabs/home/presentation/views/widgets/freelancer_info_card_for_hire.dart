import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../profile/domain/entities/user_info_entity/user_info_entity.dart';

class FreelancerInfoCardForHire extends StatelessWidget {
  final UserInfoEntity freelancer;
  final double userRating;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onReviewsTap;

  const FreelancerInfoCardForHire({
    super.key,
    required this.freelancer,
    required this.isSelected,
    required this.onTap,
    required this.userRating,
    required this.onReviewsTap, // جديد
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? ColorsManager.primary : Colors.grey.shade300,
            width: 3.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            UserAvatar(radius: 16.r,

                userName:  freelancer.fullName,
                imagePath: freelancer.profileImage),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    freelancer.fullName ?? "name is not available",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                      color: Colors.grey
                        ),
                    maxLines: 1,
                  ),
                  Text(
                    freelancer.bio ??  local.freelancer,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        color: Colors.grey
                        ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Rating
            Row(
              children: [
                Text(
                  userRating.toStringAsFixed(1) ,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      color: Colors.grey
                      ),
                ),
                const Icon(Icons.star, color: Colors.amber, size: 16),
              ],
            ),
            const SizedBox(width: 8),
            // Icon for Reviews
            GestureDetector(
              onTap: onReviewsTap,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: ColorsManager.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.reviews,
                  color: ColorsManager.primary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
