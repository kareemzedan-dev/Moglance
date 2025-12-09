import '../../../domain/entities/change_password_entity/change_password_entity.dart';

class ChangePasswordModel extends ChangePasswordEntity {
  ChangePasswordModel({
    required String currentPassword,
    required String newPassword,
  }) : super(currentPassword: currentPassword, newPassword: newPassword);

  Map<String, dynamic> toMap() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }

  factory ChangePasswordModel.fromMap(Map<String, dynamic> map) {
    return ChangePasswordModel(
      currentPassword: map['currentPassword'],
      newPassword: map['newPassword'],
    );
  }
}
