import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';
import '../../../domain/repositories/attachments_repository/attachments_repository.dart';
import '../../data_sources/remote/attachments_remote_data_source/attachments_remote_data_source.dart';

@Injectable(as: AttachmentsRepository)
class AttachmentsRepositoryImpl extends AttachmentsRepository {
  final AttachmentsRemoteDataSource remoteDataSource;
  AttachmentsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, File>> downloadAttachments(
      String url,
      String fileName, {
        String? saveDir,
      }) {
    return remoteDataSource.downloadAttachments(url, fileName, saveDir: saveDir);
  }

  @override
  Future<Either<Failures, List<AttachmentEntity>>> uploadAttachments(
      List<File> files, {
        String? bucketName,
      }) {
    return remoteDataSource.uploadAttachments(files, bucketName: bucketName);
  }

  @override
  Future<Either<Failures, void>> deleteAttachment(
      String attachmentId, {
        String? bucketName,
      }) {
    return remoteDataSource.deleteAttachment(attachmentId, bucketName: bucketName);
  }
}
