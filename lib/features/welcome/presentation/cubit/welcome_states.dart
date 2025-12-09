
enum WelcomeStatus { initial, loading, videoReady, error }

enum UserRole { freelancer, client }

class WelcomeState {
  final UserRole? selectedRole;
  final WelcomeStatus status;

  WelcomeState({
    this.selectedRole,
    this.status = WelcomeStatus.initial,
  });

  WelcomeState copyWith({
    UserRole? selectedRole,
    WelcomeStatus? status,
  }) {
    return WelcomeState(
      selectedRole: selectedRole ?? this.selectedRole,
      status: status ?? this.status,
    );
  }
}
