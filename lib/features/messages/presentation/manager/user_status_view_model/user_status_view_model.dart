import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/user_status_entity/user_status_entity.dart';
import '../../../domain/use_cases/user_status_use_case/user_status_use_case.dart';
import 'user_status_states.dart';

@injectable
class UserStatusViewModel extends Cubit<UserStatusStates> {
  final UserStatusUseCase userStatusUseCase;
  StreamSubscription<UserStatusEntity>? _subscription;

  UserStatusViewModel(this.userStatusUseCase)
      : super(UserStatusInitialStates());

  void streamUserStatus(String userId) {
    emit(UserStatusLoadingStates());

    _subscription?.cancel();
    _subscription = userStatusUseCase.streamUserStatus(userId).listen(

    (status) {
        emit(UserStatusSuccessStates(userStatus:  status));
      },
      onError: (error) {
        emit(UserStatusErrorStates(message: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
