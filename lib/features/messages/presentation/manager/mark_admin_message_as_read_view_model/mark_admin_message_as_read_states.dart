abstract class MarkAdminMessageAsReadStates {}

class MarkAdminMessageAsReadStatesInitial extends MarkAdminMessageAsReadStates {}

class MarkAdminMessageAsReadStatesLoading extends MarkAdminMessageAsReadStates {}

class MarkAdminMessageAsReadStatesSuccess extends MarkAdminMessageAsReadStates {}

class MarkAdminMessageAsReadStatesError extends MarkAdminMessageAsReadStates {
  final String message;

  MarkAdminMessageAsReadStatesError(this.message);
}
