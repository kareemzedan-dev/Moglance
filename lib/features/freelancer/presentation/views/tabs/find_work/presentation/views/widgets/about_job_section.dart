import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/helper/relative_time.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/config/l10n/app_localizations.dart';

class AboutJobSection extends StatelessWidget {
  const AboutJobSection({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.about_this_job,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,

          ),
        ),
        SizedBox(height: 16.h),

        Row(
          children: [
            Text(
              local.project_duration,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Colors.grey.shade800,
              ),
            ),
            const Spacer(),
            Text(
              order.deadline != null
                  ? order.deadline!.toRelative(context)
                  : local.unknown,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),
      ],
    );
  }
}
