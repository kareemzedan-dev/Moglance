import 'dart:io';

class DownloadAttachmentsStates {}
class DownloadAttachmentsStatesInitial extends DownloadAttachmentsStates {}
class DownloadAttachmentsStatesLoading extends DownloadAttachmentsStates {}
class DownloadAttachmentsStatesSuccess extends DownloadAttachmentsStates {
  final File file;
  DownloadAttachmentsStatesSuccess(this.file);
}
class DownloadAttachmentsStatesError extends DownloadAttachmentsStates {
  final String message;
  DownloadAttachmentsStatesError(this.message);
}