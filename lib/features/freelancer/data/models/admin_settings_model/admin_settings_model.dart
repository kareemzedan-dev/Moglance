
import '../../../domain/entities/admin_settings_entity/admin_settings_entity.dart';

class AdminSettingsModel extends AdminSettingsEntity {
  AdminSettingsModel({
    required String id,
    required double commission,
    required DateTime createdAt,
  }) : super(
         id: id,
         commission: commission,
         createdAt: createdAt,
       );

  factory AdminSettingsModel.fromJson(Map<String, dynamic> json) {
    return AdminSettingsModel(
      id: json['id'] as String,
      commission: (json['commission'] as num).toDouble(),
 
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commission': commission,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
