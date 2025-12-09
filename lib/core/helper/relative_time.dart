import 'package:flutter/material.dart';
import '../../config/l10n/app_localizations.dart';

extension RelativeTimeLocalized on DateTime {
  String toRelative(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(this); // ✅ تم التعديل هنا

    bool isPast = difference.inSeconds > 0;
    int totalSeconds = difference.inSeconds.abs();

    final days = totalSeconds ~/ (24 * 3600);
    totalSeconds -= days * 24 * 3600;

    final hours = totalSeconds ~/ 3600;
    totalSeconds -= hours * 3600;

    final minutes = totalSeconds ~/ 60;

    final suffix = isPast ? local.time_suffix_ago : local.time_suffix_left;

    if (days > 0) {
      String result =
          "$days ${days == 1 ? local.time_day : local.time_days}";
      if (hours > 0) {
        result += " $hours ${hours == 1 ? local.time_hour : local.time_hours}";
      }
      return "$result $suffix";
    } else if (hours > 0) {
      String result =
          "$hours ${hours == 1 ? local.time_hour : local.time_hours}";
      if (minutes > 0) {
        result +=
        " $minutes ${minutes == 1 ? local.time_minute : local.time_minutes}";
      }
      return "$result $suffix";
    } else if (minutes > 0) {
      return "$minutes ${minutes == 1 ? local.time_minute : local.time_minutes} $suffix";
    } else {
      return local.just_now;
    }
  }
}
