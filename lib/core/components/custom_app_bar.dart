import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'circle_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final String? image;
  final bool? isLeading;
  final bool? menuIconShow;
  final VoidCallback? onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFDDDDDD),
    this.borderWidth = 2,
    this.elevation = 0,
    this.image,
    this.isLeading = false,
    this.menuIconShow = false,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  8.0),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),

        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        elevation: elevation,
        leading: isLeading == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : menuIconShow!
            ? IconButton(onPressed: onMenuPressed, icon: const Icon(Icons.menu))
            : null,

        shape: Border(
          bottom: BorderSide(color: borderColor, width: borderWidth),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),

        actions: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircularIconButton(image: image),
            ),
        ],
        centerTitle: false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
