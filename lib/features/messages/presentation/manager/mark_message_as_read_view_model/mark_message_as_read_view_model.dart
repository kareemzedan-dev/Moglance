import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_sources/remote/mark_messages_as_read_remote_data_source/mark_messages_as_read_remote_data_source.dart';
import 'mark_message_as_read_view_model_states.dart';
@injectable
class MarkMessageAsReadViewModel
    extends Cubit<MarkMessageAsReadViewModelStates> {
  final MarkMessagesAsReadRemoteDataSource markMessagesAsReadRemoteDataSource;

  MarkMessageAsReadViewModel(this.markMessagesAsReadRemoteDataSource)
      : super(MarkMessageAsReadViewModelStates()) ;
  Future<void> markMessagesAsRead(String orderId,String currentUserId) async {
    emit(MarkMessageAsReadViewModelLoadingStates());
    final result = await markMessagesAsReadRemoteDataSource.markMessagesAsRead(orderId,currentUserId);
    result.fold(
          (failure) => emit(MarkMessageAsReadViewModelErrorStates(failure.message)),
          (success) => emit(MarkMessageAsReadViewModelSuccessStates()),
        );
  }

}
