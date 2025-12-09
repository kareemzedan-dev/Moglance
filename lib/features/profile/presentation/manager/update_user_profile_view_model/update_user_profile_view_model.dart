import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/profile/presentation/manager/update_user_profile_view_model/update_user_profile_states.dart';

import '../../../domain/entities/user_info_entity/user_info_entity.dart';
import '../../../domain/use_cases/update_user_profile_use_case/update_user_profile_use_case.dart';
@injectable
class UpdateUserProfileViewModel extends Cubit<UpdateUserProfileStates> {
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final UserInfoEntity userInfoEntity;

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;

  UpdateUserProfileViewModel(this.updateUserProfileUseCase, this.userInfoEntity)
      : super(UpdateUserProfileStatesInitial()) {
    fullNameController = TextEditingController(text: SharedPrefHelper.getString(StringsManager.fullNameKey));
    emailController = TextEditingController(text: SharedPrefHelper.getString(StringsManager.emailKey));
    phoneNumberController = TextEditingController(text: SharedPrefHelper.getString(StringsManager.phoneNumberKey)??"");
  }

  Future<void> updateUserInfo(
      String userId,
      String fullName,
      String email,
      String phoneNumber,
      String profileImage,
      ) async {
    emit(UpdateUserProfileStatesLoading());
    final result = await updateUserProfileUseCase.callUpdateUserInfo(
      userId,
      fullName,
      email,
      phoneNumber,
      profileImage,
    );
    result.fold(
          (failure) => emit(UpdateUserProfileStatesError(failure.message)),
          (success) => emit(UpdateUserProfileStatesSuccess("success updating user info")),
    );
  }
}
