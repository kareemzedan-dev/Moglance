import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/services/language_service.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/helper/language_notifier.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/colors_manger.dart';

class LanguageBottomSheetContent extends StatefulWidget {
  final String? initialLanguage;

  const LanguageBottomSheetContent({super.key, this.initialLanguage});

  @override
  State<LanguageBottomSheetContent> createState() =>
      _LanguageBottomSheetContentState();
}
class _LanguageBottomSheetContentState extends State<LanguageBottomSheetContent> {
  late String _selectedLanguageCode;

  @override
  void initState() {
    super.initState();
    // نجيب اللغة الحالية من الـ widget أو من الـ notifier لو موجود
    final languageNotifier = context.read<LanguageNotifier>();
    _selectedLanguageCode = widget.initialLanguage ?? languageNotifier.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final languages = [
      {"title": "العربية", "icon": Assets.assetsImagesArabicFlag, "code": "ar"},
      {"title": "English", "icon": Assets.assetsImagesEnglishFlag, "code": "en"},
    ];

    final languageNotifier = context.read<LanguageNotifier>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(12.w),
            itemCount: languages.length,
            separatorBuilder: (_, __) => Divider(color: Colors.grey, thickness: 0.5),
            itemBuilder: (context, index) {
              final lang = languages[index];
              final isSelected = lang["code"] == _selectedLanguageCode;

              return ListTile(
                leading: Image.asset(lang["icon"]!, width: 30.w, height: 30.w),
                title: Text(
                  lang["title"]!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(

                    fontSize: 16.sp,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.done, color: ColorsManager.primary, size: 20.sp)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguageCode = lang["code"]!;
                  });
                },
              );
            },
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              title: "Save",
              ontap: () async {
                await languageNotifier.changeLanguage(_selectedLanguageCode);
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
