import 'package:flutter/cupertino.dart';

import '../../config/l10n/app_localizations.dart';

extension DateTimeExtensions on DateTime {
  String toTimeAgo(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inMinutes < 1) {
      return   local.just_now;
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}  ${local.time_minute}";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} ${local.time_hour}";
    } else {
      return "${difference.inDays} ${local.time_day}";
    }
  }
}
