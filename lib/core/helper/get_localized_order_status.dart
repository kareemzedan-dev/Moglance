import '../../config/l10n/app_localizations.dart';

String getLocalizedStatus(AppLocalizations local, String status) {
  switch (status.toLowerCase()) {
    case "pending":
      return local.pending;
    case "accepted":
      return local.accepted;
    case "inprogress":
      return local.inProgress;
    case "completed":
      return local.completed;
    case "cancelled":
      return local.cancelled;
    case "paid":
      return local.paid;
    case "waiting":
      return local.waiting;
      case "rejected":
      return local.rejected;
    default:
      return status;
  }
}