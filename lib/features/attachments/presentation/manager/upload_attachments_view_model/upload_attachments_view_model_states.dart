import 'dart:io';

import '../../../domain/entities/attachment_entity/attaachments_entity.dart';

class UploadAttachmentsViewModelStates {}

class UploadAttachmentsViewModelStatesInitial extends UploadAttachmentsViewModelStates {}

class UploadAttachmentsViewModelStatesLoading extends UploadAttachmentsViewModelStates {}

class UploadAttachmentsViewModelStatesUploading extends UploadAttachmentsViewModelStates {
  final File file;
  final double progress;
  UploadAttachmentsViewModelStatesUploading({required this.file, required this.progress});
}

class UploadAttachmentsViewModelStatesSuccess extends UploadAttachmentsViewModelStates {
  final List<AttachmentEntity> attachments;
  final File file; // غير إلى required
  UploadAttachmentsViewModelStatesSuccess({required this.attachments, required this.file});
}

class UploadAttachmentsViewModelStatesError extends UploadAttachmentsViewModelStates {
  final String message;
  final File? file; // أبقها optional
  UploadAttachmentsViewModelStatesError({required this.message, this.file});
}

class UploadAttachmentsViewModelStatesDuplicateWarning extends UploadAttachmentsViewModelStates {
  final String message;
  UploadAttachmentsViewModelStatesDuplicateWarning({required this.message});
}