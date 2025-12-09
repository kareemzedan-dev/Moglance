import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int trimLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.style,
    this.trimLines = 2,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final textWidget = Text(
      widget.text,
      style: widget.style,
      maxLines: isExpanded ? null : widget.trimLines,
      overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget,
        if (widget.text.length > 100)
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Text(
              isExpanded ? local.view_less : local.view_more,
              style: widget.style?.copyWith(
                color: ColorsManager.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          )
      ],
    );
  }
}
