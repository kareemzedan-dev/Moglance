import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/core/components/custom_search_text_field.dart';
class SearchBarWithFavorite extends StatelessWidget {
  final List<String> hintTexts;
  final ValueChanged<String>? onChanged; // هنا بنستقبل callback

  const SearchBarWithFavorite({
    super.key,
    required this.hintTexts,
    this.onChanged, // optional
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchTextField(
            hintTexts: hintTexts,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RoutesManager.favouriteOrdersView);
          },
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: ColorsManager.primary,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: const Icon(
              Icons.favorite,
              color: ColorsManager.primary,
            ),
          ),
        ),
      ],
    );
  }
}
