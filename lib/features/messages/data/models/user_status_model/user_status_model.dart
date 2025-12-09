
import '../../../domain/entities/user_status_entity/user_status_entity.dart';

class UserStatusModel extends UserStatusEntity {
  const UserStatusModel({
    required super.isOnline,
    required super.lastSeen,
  });

  factory UserStatusModel.fromJson(Map<String, dynamic> json) {
    return UserStatusModel(
      isOnline: json['isOnline'] ?? false,
      lastSeen: json['lastSeen'] is String
          ? DateTime.parse(json['lastSeen'])
          : (json['lastSeen'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['lastSeen'])
          : DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isOnline': isOnline,
      'lastSeen': lastSeen.toIso8601String(),
    };
  }
}
