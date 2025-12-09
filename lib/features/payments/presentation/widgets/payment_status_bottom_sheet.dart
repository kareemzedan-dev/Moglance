import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/shared/presentation/views/widgets/attachments_section.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

import '../../../../config/l10n/app_localizations.dart';

class PaymentStatusBottomSheet extends StatelessWidget {
  final PaymentEntity payment;

  const PaymentStatusBottomSheet({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Container(

      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration:   BoxDecoration(
        color: ColorsManager.white ,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              // Info message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorsManager.primary.withOpacity(0.2),
                ),
                child: Text(
                  local.payment_under_review_message,
                  style: TextStyle(
                    color: ColorsManager.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 20.h),

              // Payment status header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    local.payment_status,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child:   Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              local.awaiting_approval,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        payment.createdAt.toString().split(' ').first,  
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              // Amount
              Text(
                "${payment.amount.toString()} ${local.sar}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              )
,
              SizedBox(height: 20.h),

              // Attachments
              AttachmentsSection(
                attachmentEntity: payment.attachments,
                isFreelancer: false,
              ),

              SizedBox(height: 20.h),

              // Support message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorsManager.primary.withOpacity(0.2),
                ),
                child: Text(
                 local.contact_us_note,
                  style: TextStyle(
                    color: ColorsManager.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              SizedBox(height: 10.h),

              CustomButton(
                title: local.chat_with_admin,
                ontap: () {
                  Navigator.pushNamed(context, RoutesManager.adminChatView, arguments:  {
                    "currentUserId": payment.clientId,

                  });
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
