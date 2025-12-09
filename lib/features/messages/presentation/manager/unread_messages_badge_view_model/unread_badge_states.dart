
import '../../../../../core/errors/failures.dart';

abstract class UnreadMessagesBadgeState {}

class UnreadMessagesBadgeInitial extends UnreadMessagesBadgeState {}

class UnreadMessagesBadgeUpdated extends UnreadMessagesBadgeState {
  final Map<String, int> unreadCounts;
  UnreadMessagesBadgeUpdated(this.unreadCounts);
}

class UnreadMessagesBadgeError extends UnreadMessagesBadgeState {
  final Failures failure;
  UnreadMessagesBadgeError(this.failure);
}
