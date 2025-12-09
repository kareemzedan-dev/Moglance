import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';

class WithdrawalHistoryTabContent extends StatelessWidget {
  const WithdrawalHistoryTabContent({super.key, required this.payment});
  final PaymentEntity payment;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2.w),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${payment.amount.toString()} ${local.sar}",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: Colors.amber,
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                          _localizedStatus(context, payment.status),
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.mobile,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                         payment.paymentMethod?? local.loading,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                           payment.accountNumber??  local.loading,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                       DateFormat("yyyy-MM-dd").format(payment.createdAt),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
    String _localizedStatus(BuildContext context, String status) {
    final local = AppLocalizations.of(context)!;
    switch (status) {
      case 'pending':
        return local.pending;
      case 'Approved':
        return local.accepted;
      case 'Rejected':
        return local.rejected;
      default:
        return status;
    }
  }
}

