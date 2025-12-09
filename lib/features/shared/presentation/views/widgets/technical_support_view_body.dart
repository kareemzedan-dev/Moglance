import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/shared/presentation/views/widgets/faq_card.dart';

class TechnicalSupportViewBody extends StatelessWidget {
  const TechnicalSupportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final List<Map<String, String>> faqs = [
      {
        "question": local.howToRequestService,
        "answer": local.requestServiceAnswer
      },
      {
        "question": local.howToDeleteService,
        "answer": local.deleteServiceAnswer
      },
      {
        "question": local.howToContactSupport,
        "answer": local.contactSupportAnswer
      },
      {
        "question": local.howToChatWithAdmin,
        "answer": local.chatWithAdminAnswer
      },
      {
        "question": local.howToUpdateProfile,
        "answer": local.updateProfileAnswer
      },
      {
        "question": local.howToChangePassword,
        "answer": local.changePasswordAnswer
      },
      {
        "question": local.howToChangeName,
        "answer": local.changeNameAnswer
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              local.contactUs,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16.h),
            Card(
              elevation: 10,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Theme.of(context).scaffoldBackgroundColor,

                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        local.contactUsOn,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: ColorsManager.primary),
                          SizedBox(width: 10.w),
                          Text(
                            "011 000 0000",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: ColorsManager.primary),
                          SizedBox(width: 10.w),
                          Text(
                            "111",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        local.sendMessageOn,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          const Icon(Icons.email, color: ColorsManager.primary),
                          SizedBox(width: 10.w),
                          Text(
                            "qN2bS@example.com",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(local.faq, style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 16.h),

            ...faqs.map(
                  (faq) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: FAQCard(
                  question: faq['question']!,
                  answer: faq['answer']!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}