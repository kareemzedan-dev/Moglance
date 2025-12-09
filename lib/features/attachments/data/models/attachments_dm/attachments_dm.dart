import 'package:taskly/features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';

class AttachmentModel extends AttachmentEntity {
  const AttachmentModel({
    required super.id,
    required super.name,
    required super.url,
    required super.size,
    required super.type,
    required super.storagePath,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      size: json['size'] ?? 0,
      type: json['type'] ?? '',
      storagePath: json['storagePath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'size': size,
      'type': type,
      'storagePath': storagePath,
    };
  }

  factory AttachmentModel.fromEntity(AttachmentEntity entity) {
    return AttachmentModel(
      id: entity.id,
      name: entity.name,
      url: entity.url,
      size: entity.size,
      type: entity.type,
      storagePath: entity.storagePath,
    );
  }
  AttachmentModel copyWith({String? name, String? storagePath, String? url, int? size, String? type,}) {
    return AttachmentModel(
      name: name ?? this.name,
      storagePath: storagePath ?? this.storagePath,
      id: id,
      url: url ?? this.url ,
      size: size ?? this.size,
      type: type ?? this.type,

    );
  }
  AttachmentEntity toEntity() {
    return AttachmentEntity(
      id: id,
      name: name,
      url: url,
      size: size,
      type: type,
      storagePath: storagePath,
    );
  }
}
