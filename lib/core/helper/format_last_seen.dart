import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/l10n/app_localizations.dart';

String formatLastSeen({
  required BuildContext context,
  required bool isOnline,
  DateTime? lastSeen,
}) {
  final local = AppLocalizations.of(context)!;

  if (isOnline) return local.online;

  if (lastSeen == null) return local.last_seen_unknown;

  final now = DateTime.now();
  final difference = now.difference(lastSeen);

  // لو النهاردة
  if (difference.inDays == 0) {
    final formattedTime = DateFormat('hh:mm a').format(lastSeen);
    return local.last_seen_today(formattedTime);
  }

  // لو امبارح
  if (difference.inDays == 1) {
    final formattedTime = DateFormat('hh:mm a').format(lastSeen);
    return local.last_seen_yesterday(formattedTime);
  }

  // لو خلال أسبوع
  if (difference.inDays < 7) {
    return local.last_seen_days_ago(difference.inDays.toString());
  }

  // لو من أكتر من أسبوع → نعرض التاريخ كامل
  final formattedDate = DateFormat('MMM d, yyyy').format(lastSeen);
  return local.last_seen_on_date(formattedDate);
}
