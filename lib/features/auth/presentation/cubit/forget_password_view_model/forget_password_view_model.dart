import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/auth/forget_password_use_case/forget_password_use_case.dart';
import 'forget_password_view_model_states.dart';
@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordViewModelStates> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordViewModel(this.forgetPasswordUseCase) : super(ForgetPasswordViewModelStatesInitial());


  Future<void> forgetPassword(String email) async {
    try {
      emit(ForgetPasswordViewModelStatesLoading());
      final result = await forgetPasswordUseCase(email);
      result.fold(
              (failure) => emit(ForgetPasswordViewModelStatesError(failure.toString())),
              (_) => emit(ForgetPasswordViewModelStatesSuccess("Reset password email sent successfully"))
      );

    }
    catch (e){
      emit(ForgetPasswordViewModelStatesError(e.toString()));
    }

  }
}