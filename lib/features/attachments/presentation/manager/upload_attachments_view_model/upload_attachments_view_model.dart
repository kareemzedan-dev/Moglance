import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model_states.dart';
import '../../../../../core/errors/failures.dart';
import '../../../data/models/attachments_dm/attachments_dm.dart';
import '../../../domain/entities/attachment_entity/attaachments_entity.dart';
import '../../../domain/use_cases/upload_attachments/upload_attachments_use_case.dart';

@injectable
class UploadAttachmentsViewModel
    extends Cubit<UploadAttachmentsViewModelStates> {
  UploadAttachmentsViewModel(this.uploadAttachmentsUseCase)
      : super(UploadAttachmentsViewModelStatesInitial());

  final UploadAttachmentsUseCase uploadAttachmentsUseCase;

  List<File> files = [];
  final Set<String> uploadedFileHashes = {};
  final Map<File, String> _fileKeys = {};
  int _fileCounter = 0;

  List<AttachmentModel> uploadedAttachments = [];

  void Function(List<AttachmentModel> attachments)? onFileUploadedSuccessfully;

  String generateFileKey(File file) {
    if (!_fileKeys.containsKey(file)) {
      _fileKeys[file] =
          'file_${_fileCounter++}_${DateTime.now().millisecondsSinceEpoch}';
    }
    return _fileKeys[file]!;
  }

  Future<String> generateFileHash(File file) async {
    final fileName = file.path.split('/').last;
    final fileSize = await file.length();
    return '$fileName-$fileSize';
  }

  /// ✅ اختيار ملف من الجهاز ورفعه مباشرة
  Future<void> pickFilesFromDevice({
    String? bucketName,
    bool singleFileMode = false,
  }) async {
    try {

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: !singleFileMode,
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'gif',
          'pdf',
          'doc',
          'docx',
          'ppt',
          'pptx',
          'xls',
          'xlsx',
          'zip',
          'rar',
        ],
      );

      if (result != null && result.files.isNotEmpty) {
        final platformFile = result.files.first;

        if (platformFile.path != null) {
          final file = File(platformFile.path!);
          final fileHash = await generateFileHash(file);

          final alreadySelected = await Future.wait(files.map(generateFileHash))
              .then((hashes) => hashes.contains(fileHash));

          if (alreadySelected) return;

          if (singleFileMode) files.clear();

          files.add(file);
          generateFileKey(file);

          emit(UploadAttachmentsViewModelStatesInitial());

          await uploadAttachments(bucketName: bucketName);
        }
      }
    } catch (e) {
      emit(UploadAttachmentsViewModelStatesError(message: e.toString()));
    }
  }

  /// ✅ حذف ملف من الكيو الحالي
  Future<void> removeFileFromQueue(File file) async {
    final fileHash = await generateFileHash(file);
    files.remove(file);
    _fileKeys.remove(file);
    uploadedFileHashes.remove(fileHash);
    uploadedAttachments.removeWhere(
      (e) => e.name == file.path.split('/').last,
    );
    emit(UploadAttachmentsViewModelStatesInitial());
  }

  /// ✅ رفع الملفات مع تتبع التقدم
  Future<Either<Failures, List<AttachmentEntity>>> uploadAttachments({
    String? bucketName,
  }) async {
    try {
      emit(UploadAttachmentsViewModelStatesLoading());

      final newFiles = <File>[];

      for (final file in files) {
        final hash = await generateFileHash(file);
        if (!uploadedFileHashes.contains(hash)) {
          newFiles.add(file);
        }
      }

      if (newFiles.isEmpty) {
        emit(UploadAttachmentsViewModelStatesInitial());
        return const Right([]);
      }

      for (final file in newFiles) {
        emit(UploadAttachmentsViewModelStatesUploading(
            file: file, progress: 0.0));

        final result = await uploadAttachmentsUseCase.callUploadAttachments(
          [file],
          bucketName: bucketName,
        );

        // نضيف تقدم تدريجي عشان نضمن ظهور المؤشر
        for (double progress = 0.1; progress <= 1.0; progress += 0.1) {
          await Future.delayed(const Duration(milliseconds: 150));
          emit(UploadAttachmentsViewModelStatesUploading(
            file: file,
            progress: progress,
          ));
        }

        result.fold(
          (failure) {
            emit(UploadAttachmentsViewModelStatesError(
              message: failure.message,
              file: file,
            ));
          },
          (attachments) async {
            final hash = await generateFileHash(file);
            uploadedFileHashes.add(hash);

            final attachment = attachments.first;
            uploadedAttachments.add(AttachmentModel(
              id: attachment.id,
              name: attachment.name,
              size: attachment.size,
              type: attachment.type,
              url: attachment.url,
              storagePath: attachment.storagePath,
            ));

            emit(UploadAttachmentsViewModelStatesSuccess(
              attachments: attachments,
              file: file,
            ));

            // ✅ نادِي الكول باك عشان تبعت رسالة تلقائيًا بعد الرفع
            if (onFileUploadedSuccessfully != null) {
              onFileUploadedSuccessfully!([
                AttachmentModel(
                  id: attachment.id,
                  name: attachment.name,
                  size: attachment.size,
                  type: attachment.type,
                  url: attachment.url,
                  storagePath: attachment.storagePath,
                )
              ]);
            }
          },
        );
      }

      return Right(uploadedAttachments);
    } catch (e) {
      final failure = ServerFailure(e.toString());
      emit(UploadAttachmentsViewModelStatesError(
        message: failure.message,
        file: files.isNotEmpty ? files.first : null,
      ));
      return Left(failure);
    }
  }

  /// ✅ رفع ملف واحد مع تتبع التقدم
  Future<Either<Failures, AttachmentEntity>> uploadSingleAttachment(
    File file, {
    required String bucketName,
  }) async {
    try {
      emit(
          UploadAttachmentsViewModelStatesUploading(file: file, progress: 0.0));

      final result = await Future.any([
        uploadAttachmentsUseCase
            .callUploadAttachments([file], bucketName: bucketName),
        Future.delayed(const Duration(minutes: 15),
            () => throw TimeoutException("Upload taking too long")),
      ]);

      for (double progress = 0.1; progress <= 1.0; progress += 0.1) {
        await Future.delayed(const Duration(milliseconds: 150));
        emit(UploadAttachmentsViewModelStatesUploading(
          file: file,
          progress: progress,
        ));
      }

      return result.fold(
        (failure) {
          emit(UploadAttachmentsViewModelStatesError(
            message: failure.message,
            file: file,
          ));
          return Left(failure);
        },
        (attachments) async {
          final hash = await generateFileHash(file);
          uploadedFileHashes.add(hash);

          final attachment = attachments.first;
          uploadedAttachments.add(AttachmentModel(
            id: attachment.id,
            name: attachment.name,
            size: attachment.size,
            type: attachment.type,
            url: attachment.url,
            storagePath: attachment.storagePath,
          ));

          emit(UploadAttachmentsViewModelStatesSuccess(
            attachments: attachments,
            file: file,
          ));

          if (onFileUploadedSuccessfully != null) {
            onFileUploadedSuccessfully!([
              AttachmentModel(
                id: attachment.id,
                name: attachment.name,
                size: attachment.size,
                type: attachment.type,
                url: attachment.url,
                storagePath: attachment.storagePath,
              )
            ]);
          }

          return Right(attachment);
        },
      );
    } catch (e) {
      if (e is TimeoutException) {
        print("⚠️ Upload still in progress but exceeded 10 minutes.");
        if (files.isNotEmpty) {
          emit(UploadAttachmentsViewModelStatesUploading(
            file: files.first,
            progress: 0.99,
          ));
        }

        // نرجّع آخر ملف تم رفعه بنجاح لو موجود
        if (uploadedAttachments.isNotEmpty) {
          final last = uploadedAttachments.last;
          final attachmentEntity = AttachmentEntity(
            id: last.id,
            name: last.name,
            size: last.size,
            type: last.type,
            url: last.url,
            storagePath: last.storagePath,
          );
          return Right(attachmentEntity);
        }

        // لو مفيش أي ملف مرفوع فعليًا
        return Left(ServerFailure("Upload timed out but no completed file."));
      }

      final failure = ServerFailure(e.toString());
      if (files.isNotEmpty) {
        emit(UploadAttachmentsViewModelStatesError(
          message: failure.message,
          file: files.first,
        ));
      } else {
        emit(UploadAttachmentsViewModelStatesError(
          message: failure.message,
        ));
      }

      return Left(failure);
    }
  }


  Future<void> clearFiles() async {
    final List<File> filesToKeep = [];
    for (final file in files) {
      final hash = await generateFileHash(file);
      if (uploadedFileHashes.contains(hash)) {
        filesToKeep.add(file);
      }
    }
    files = filesToKeep;
    emit(UploadAttachmentsViewModelStatesInitial());
  }

  void clearAllFiles() {
    files.clear();
    uploadedFileHashes.clear();
    _fileKeys.clear();
    _fileCounter = 0;
    emit(UploadAttachmentsViewModelStatesInitial());
  }
}
