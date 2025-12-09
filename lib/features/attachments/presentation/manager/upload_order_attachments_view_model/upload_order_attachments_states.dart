


import 'package:taskly/features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';

class UploadOrderAttachmentsViewModelStates {}
class UploadOrderAttachmentsViewModelStatesInitial extends UploadOrderAttachmentsViewModelStates {}
class UploadOrderAttachmentsViewModelStatesLoading extends UploadOrderAttachmentsViewModelStates {}
class UploadOrderAttachmentsViewModelStatesSuccess extends UploadOrderAttachmentsViewModelStates {
  final List<AttachmentEntity> attachments;
  UploadOrderAttachmentsViewModelStatesSuccess({required this.attachments});
}
class UploadOrderAttachmentsViewModelStatesError extends UploadOrderAttachmentsViewModelStates {
  final String message;
  UploadOrderAttachmentsViewModelStatesError({required this.message});
}class UploadOrderAttachmentsViewModelStatesDuplicateWarning extends UploadOrderAttachmentsViewModelStates {


}
