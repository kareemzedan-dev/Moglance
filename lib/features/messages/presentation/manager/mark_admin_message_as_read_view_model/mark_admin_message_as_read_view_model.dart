import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/use_cases/mark_message_read_use_case/mark_message_read_use_case.dart';

import 'mark_admin_message_as_read_states.dart';

@injectable
class MarkAdminMessageAsReadViewModel
    extends Cubit<MarkAdminMessageAsReadStates> {
  final MarkMessagesAsReadUseCase markMessageReadUseCase;

  MarkAdminMessageAsReadViewModel(this.markMessageReadUseCase)
    : super(MarkAdminMessageAsReadStatesInitial());

  Future<void> markAdminMessageAsRead(String currentId) async {
    emit(MarkAdminMessageAsReadStatesLoading());
    final result = await markMessageReadUseCase.callAdmin(currentId);
    result.fold(
      (failure) => emit(MarkAdminMessageAsReadStatesError(failure.message)),
      (success) => emit(MarkAdminMessageAsReadStatesSuccess()),
    );
  }
}
