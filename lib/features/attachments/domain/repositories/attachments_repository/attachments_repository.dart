import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';

abstract class AttachmentsRepository {
  /// Download a file from [url] and save it with [fileName].
  /// Optionally specify [saveDir].
  Future<Either<Failures, File>> downloadAttachments(
      String url,
      String fileName, {
        String? saveDir,
      });

  /// Upload a list of [files].
  /// Optionally specify a [bucketName] to upload to a custom bucket.
  Future<Either<Failures, List<AttachmentEntity>>> uploadAttachments(
      List<File> files, {
        String? bucketName,
      });

  /// Delete an attachment by [storagePath].
  /// Optionally specify a [bucketName] if not using the default.
  Future<Either<Failures, void>> deleteAttachment(
      String storagePath, {
        String? bucketName,
      });
}
