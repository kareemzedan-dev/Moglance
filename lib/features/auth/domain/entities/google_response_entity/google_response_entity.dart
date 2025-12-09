class SocialUserEntity {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String role; // admin, client, freelancer, etc.

  SocialUserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.role,
  });
}

class SocialAuthResponseEntity {
  final String? token;
  final SocialUserEntity? user;
  final String? message;

  SocialAuthResponseEntity({this.token, this.user, this.message});
}