import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../repositories/attachments_repository/attachments_repository.dart';
@injectable
class DownloadAttachmentsUseCase {
  final AttachmentsRepository repository;

  DownloadAttachmentsUseCase(this.repository);

  Future<Either<Failures, File>> callDownloadAttachments(
      String url,
      String fileName, {
        String? saveDir,
      }) =>
      repository.downloadAttachments(url, fileName, saveDir: saveDir);
}
