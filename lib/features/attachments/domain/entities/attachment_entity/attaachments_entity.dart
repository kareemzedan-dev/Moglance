import 'dart:io';

class AttachmentEntity {
  final String id;
  final String name;
  final String url;
  final int size;
  final String type;
  final String storagePath;

  const AttachmentEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.size,
    required this.type,
    required this.storagePath,
  });
}

class AttachmentFile {
  final File file;
  final bool isUploaded;
  final String? hash;

  AttachmentFile({
    required this.file,
    this.isUploaded = false,
    this.hash,
  });

  AttachmentFile copyWith({
    File? file,
    bool? isUploaded,
    String? hash,
  }) {
    return AttachmentFile(
      file: file ?? this.file,
      isUploaded: isUploaded ?? this.isUploaded,
      hash: hash ?? this.hash,
    );
  }
}