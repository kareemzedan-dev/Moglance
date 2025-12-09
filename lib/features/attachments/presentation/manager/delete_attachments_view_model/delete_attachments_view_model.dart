import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/attachments/domain/use_cases/delete_attachments/delete_attachments_use_case.dart';

import 'delete_attachments_view_model_states.dart';
@injectable
class DeleteAttachmentsViewModel extends Cubit<DeleteAttachmentsViewModelStates> {
 final DeleteAttachmentsUseCase deleteAttachmentsUseCase ;

  DeleteAttachmentsViewModel(this.deleteAttachmentsUseCase)
      : super(DeleteAttachmentsViewModelStatesInitial());

  Future<Either<Failures, void>> deleteAttachment(String attachmentId) async {
    try {
      emit(DeleteAttachmentsViewModelStatesLoading());

      final result = await deleteAttachmentsUseCase.callDeleteAttachment(attachmentId);

      return result.fold(
            (failure) {
          emit(DeleteAttachmentsViewModelStatesError( failure.message));
          return Left(failure);
        },
            (r) {
          emit(DeleteAttachmentsViewModelStatesSuccess("Attachment deleted successfully"));
          return const Right(null);
        },
      );
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(DeleteAttachmentsViewModelStatesError(  failure.message));
      return Left(failure);
    }
  }
}
