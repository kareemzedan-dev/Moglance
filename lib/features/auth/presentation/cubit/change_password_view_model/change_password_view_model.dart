import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/auth/domain/use_cases/auth/change_password_use_case/change_password_use_case.dart';
import 'package:taskly/features/auth/presentation/cubit/change_password_view_model/change_password_view_model_states.dart';
@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordViewModelStates> {
  ChangePasswordViewModel(this.changePasswordUseCase) : super(ChangePasswordViewModelInitial());

  final ChangePasswordUseCase changePasswordUseCase;

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      emit(ChangePasswordViewModelLoadingState());

      final result = await changePasswordUseCase(currentPassword, newPassword);

      result.fold(
            (failure) => emit(ChangePasswordViewModelErrorState("There was an error changing your password")),
            (_) => emit(ChangePasswordViewModelSuccessState("Password changed successfully")), // لازم تضيف state للنجاح
      );
    } catch (e) {
      emit(ChangePasswordViewModelErrorState(e.toString()));
    }
  }
}
