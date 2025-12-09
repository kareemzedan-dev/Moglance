import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/download_attachments/download_attachments.dart';
import 'download_attachments_states.dart';
@injectable
class DownloadAttachmentsViewModel extends Cubit<DownloadAttachmentsStates> {
  DownloadAttachmentsViewModel(this.attachmentUseCase)
      : super(DownloadAttachmentsStatesInitial());

  final DownloadAttachmentsUseCase attachmentUseCase;

  Future<Either<Failures, File>> downloadAttachments(
      String url, String fileName) async {
    try {
      emit(DownloadAttachmentsStatesLoading());
      final result = await attachmentUseCase.callDownloadAttachments(
        url,
        fileName,
      );
      emit(
        result.fold(
              (l) => DownloadAttachmentsStatesError(l.message),
              (r) => DownloadAttachmentsStatesSuccess(r),
        ),
      );
      return result;
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(DownloadAttachmentsStatesError(failure.message));
      return Left(failure);
    }
  }
}
