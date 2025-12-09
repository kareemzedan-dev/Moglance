
abstract class ChatAvatarsState {}

class ChatAvatarsLoading extends ChatAvatarsState {}

class ChatAvatarsLoaded extends ChatAvatarsState {
  final String? freelancerAvatar;
  final String? clientAvatar;

  ChatAvatarsLoaded({
    this.freelancerAvatar,
    this.clientAvatar,
  });
}

class ChatAvatarsError extends ChatAvatarsState {
  final String message;
  ChatAvatarsError(this.message);
}
