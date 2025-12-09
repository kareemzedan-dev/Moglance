import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class WalletCard extends StatelessWidget {
  final String availableBalance;
  final String totalEarnings;
  final String withdrawn;

  const WalletCard({
    super.key,
    required this.availableBalance,
    required this.totalEarnings,
    required this.withdrawn,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primary,
            ColorsManager.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local.freelancerWallet,
            style: textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            local.availableBalance,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
          Text(
            availableBalance,
            style: textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28.sp,
            ),
          ),

          SizedBox(height: 30.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat(
                label: local.totalEarnings,
                value: totalEarnings,
                textTheme: textTheme,
              ),
              _buildStat(
                label: local.withdrawn,
                value: withdrawn,
                textTheme: textTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat({
    required String label,
    required String value,
    required TextTheme textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white70,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          value,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}