import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/l10n/app_localizations.dart';


class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool isTyping;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.isTyping,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(30.r),
        border: Border.all( ),
      ),
      child: TextField(
        style:  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp ),

        controller: controller,
        onChanged: onChanged,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "اكتب رسالتك",
          hintStyle:Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp, ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }
}