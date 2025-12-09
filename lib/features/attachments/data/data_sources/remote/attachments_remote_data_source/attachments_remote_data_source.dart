import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:taskly/features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';
import '../../../../../../core/errors/failures.dart';

abstract class AttachmentsRemoteDataSource {
  /// Download a file from [url] and save it with [fileName].
  /// Optionally, specify a custom [saveDir].
  Future<Either<Failures, File>> downloadAttachments(
      String url,
      String fileName, {
        String? saveDir,
      });

  /// Upload a list of [files] to Supabase.
  /// Optionally, specify a [bucketName] to upload to a different bucket.
  Future<Either<Failures, List<AttachmentEntity>>> uploadAttachments(
      List<File> files, {
        String? bucketName,
      });

  /// Delete an attachment by [storagePath] (or ID if implementation uses it).
  /// Optionally, specify a [bucketName] if the file is not in the default bucket.
  Future<Either<Failures, void>> deleteAttachment(
      String storagePath, {
        String? bucketName,
      });
}
