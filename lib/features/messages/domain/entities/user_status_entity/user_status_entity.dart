class UserStatusEntity {
  final bool isOnline;
  final DateTime lastSeen;

  const UserStatusEntity({
    required this.isOnline,
    required this.lastSeen,
  });
}
