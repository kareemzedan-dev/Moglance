import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';
import 'package:taskly/features/attachments/domain/repositories/attachments_repository/attachments_repository.dart';

@injectable
class UploadAttachmentsUseCase {
  final AttachmentsRepository attachmentsRepository;

  UploadAttachmentsUseCase({required this.attachmentsRepository});

  /// Upload files with optional [bucketName] for flexibility
  Future<Either<Failures, List<AttachmentEntity>>> callUploadAttachments(
      List<File> files, {
        String? bucketName,
      }) =>
      attachmentsRepository.uploadAttachments(
        files,
        bucketName: bucketName,
      );
}
