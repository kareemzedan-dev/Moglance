
// Model للمستخدم
import '../../../domain/entities/google_response_entity/google_response_entity.dart';

class GoogleUserDm extends SocialUserEntity {
  GoogleUserDm({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
    required String role,
  }) : super(
    id: id,
    name: name,
    email: email,
    avatarUrl: avatarUrl,
    role: role,
  );

  factory GoogleUserDm.fromJson(Map<String, dynamic> json) {
    return GoogleUserDm(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'role': role,
    };
  }

  SocialUserEntity toEntity() {
    return SocialUserEntity(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      role: role,
    );
  }
}

class GoogleAuthResponseDm extends SocialAuthResponseEntity {
  GoogleAuthResponseDm({
    String? token,
    GoogleUserDm? user,
    String? message,
  }) : super(token: token, user: user, message: message);

  factory GoogleAuthResponseDm.fromJson(Map<String, dynamic> json) {
    return GoogleAuthResponseDm(
      token: json['token'] as String?,
      user: json['user'] != null
          ? GoogleUserDm.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }}