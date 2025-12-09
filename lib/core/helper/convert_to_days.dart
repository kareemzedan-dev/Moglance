import 'package:flutter/material.dart';

import '../../config/l10n/app_localizations.dart';

int convertToMinutes(int value, String unit) {
  switch (unit) {
    case 'Hours':
    case 'ساعات':
      return value * 60;

    case 'Days':
    case 'أيام':
      return value * 24 * 60;

    case 'Weeks':
    case 'أسابيع':
      return value * 7 * 24 * 60;

    default:
      return value;
  }
}


extension FormatMinutesExtension on int {
  String formatMinutes(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    int minutes = this;

    if (minutes >= 7 * 24 * 60) {
      int weeks = minutes ~/ (7 * 24 * 60);
      int remainingMinutes = minutes % (7 * 24 * 60);
      int days = remainingMinutes ~/ (24 * 60);

      if (days > 0) {
        return "$weeks ${weeks == 1 ? loc.week : loc.weeks} "
            "$days ${days == 1 ? loc.day : loc.days}";
      } else {
        return "$weeks ${weeks == 1 ? loc.week : loc.weeks}";
      }
    } else if (minutes >= 24 * 60) {
      int days = minutes ~/ (24 * 60);
      int remainingMinutes = minutes % (24 * 60);
      int hours = remainingMinutes ~/ 60;

      if (hours > 0) {
        return "$days ${days == 1 ? loc.day : loc.days} "
            "$hours ${hours == 1 ? loc.hour : loc.hours}";
      } else {
        return "$days ${days == 1 ? loc.day : loc.days}";
      }
    } else if (minutes >= 60) {
      int hours = minutes ~/ 60;
      int remainingMinutes = minutes % 60;

      if (remainingMinutes > 0) {
        return "$hours ${hours == 1 ? loc.hour : loc.hours} "
            "$remainingMinutes ${remainingMinutes == 1 ? loc.minute : loc.minutes}";
      } else {
        return "$hours ${hours == 1 ? loc.hour : loc.hours}";
      }
    } else {
      return "$minutes ${minutes == 1 ? loc.minute : loc.minutes}";
    }
  }
}
