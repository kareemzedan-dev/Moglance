import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/utils/colors_manger.dart';

import '../../../../../core/services/theme_notifier.dart';

class ThemeBottomSheetContent extends StatefulWidget {
  final String? initialTheme;

  const ThemeBottomSheetContent({super.key, this.initialTheme});

  @override
  State<ThemeBottomSheetContent> createState() =>
      _ThemeBottomSheetContentState();
}

class _ThemeBottomSheetContentState extends State<ThemeBottomSheetContent> {
  String? _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.initialTheme; // استخدام S.current
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final themes = [
      {"title": local.lightTheme, "icon": Icons.light_mode},
      {"title": local.darkTheme, "icon": Icons.dark_mode},

   //   {"title": local.systemDefault, "icon": Icons.settings},
    ];

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
            itemCount: themes.length,
            separatorBuilder:
                (_, __) => const Divider(color: Colors.grey, thickness: 0.5),
            itemBuilder: (context, index) {
              final theme = themes[index];
              final isSelected = theme["title"] == _selectedTheme;

              return ListTile(
                leading: Icon(
                  theme["icon"] as IconData,
                  color: ColorsManager.primary,
                ),
                title: Text(
                  theme["title"] as String,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith( fontSize: 16.sp,),
                ),
                trailing: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(  width: 2),
                    color:
                    isSelected ? ColorsManager.primary : Colors.transparent,
                  ),
                  child:
                  isSelected
                      ? Icon(
                    Icons.done,

                    size: 16.sp,
                  )
                      : null,
                ),
                onTap: () {
                  setState(() {
                    _selectedTheme = theme["title"] as String;
                  });
                },
              );
            },
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              title: local.save,
              ontap: () async {
                if (_selectedTheme != null) {
                  // حفظ الثيم
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('app_theme', _selectedTheme!);

                  // تغيير الثيم وقت الاختيار
                  final themeNotifier = context.read<ThemeNotifier>();
                  themeNotifier.setTheme(_selectedTheme!);

                  Navigator.pop(context, _selectedTheme);
                }
              },
            ),

          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}