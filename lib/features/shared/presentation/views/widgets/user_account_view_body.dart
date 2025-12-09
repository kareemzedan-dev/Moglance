import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/components/custom_text_field.dart';
import 'package:taskly/core/components/dismissible_error_card.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/profile/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';
import '../../../../../config/l10n/app_localizations.dart';
import '../../../../../core/services/pick_image_from_camera.dart';
import '../../../../profile/domain/use_cases/update_user_profile_use_case/update_user_profile_use_case.dart';
import '../../../../profile/presentation/manager/update_user_profile_view_model/update_user_profile_states.dart';
import '../../../../profile/presentation/manager/update_user_profile_view_model/update_user_profile_view_model.dart';

class UserAccountViewBody extends StatefulWidget {
  const UserAccountViewBody({super.key, required this.userInfoEntity});

  final UserInfoEntity userInfoEntity;

  @override
  State<UserAccountViewBody> createState() => _UserAccountViewBodyState();

}

class _UserAccountViewBodyState extends State<UserAccountViewBody> {
  late final local = AppLocalizations.of(context)!;
  String? _pickedImagePath;


  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title:   Text(local.takePhoto,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),),
              onTap: () async {
                Navigator.pop(context); // close bottom sheet
                await _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title:   Text(local.chooseFromGallery,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),),
              onTap: () async {
                Navigator.pop(context); // close bottom sheet
                await _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final imagePath = await ImagePickerService.pickImageFromCamera();
      if (imagePath != null) {
        setState(() {
          _pickedImagePath = imagePath;
        });
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final imagePath = await ImagePickerService.pickImageFromGallery();
      if (imagePath != null) {
        setState(() {
          _pickedImagePath = imagePath;
        });
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!; // استخدام S.of(context) بدلاً من AppLocalizations.of(context)!

    return BlocProvider(
        create: (context) => UpdateUserProfileViewModel(
          getIt<UpdateUserProfileUseCase>(),
          widget.userInfoEntity,
        ),
        child:
        BlocConsumer<UpdateUserProfileViewModel, UpdateUserProfileStates>(
            listener: (context, state) {

              if (state is UpdateUserProfileStatesError) {
                showTemporaryMessage(
                  context,
                  local.profileUpdateFailed,
                  MessageType.error,
                );
              }
              if (state is UpdateUserProfileStatesSuccess) {
                SharedPrefHelper.setString(
                    StringsManager.fullNameKey,
                    context
                        .read<UpdateUserProfileViewModel>()
                        .fullNameController
                        .text);
                SharedPrefHelper.setString(
                    StringsManager.emailKey,
                    context
                        .read<UpdateUserProfileViewModel>()
                        .emailController
                        .text);
                SharedPrefHelper.setString(
                    StringsManager.phoneNumberKey,
                    context
                        .read<UpdateUserProfileViewModel>()
                        .phoneNumberController
                        .text);
                SharedPrefHelper.setString(
                    StringsManager.profileImageKey,
                    _pickedImagePath ??
                        SharedPrefHelper.getString(
                            StringsManager.profileImageKey)!);


                if (SharedPrefHelper.getString(StringsManager.roleKey) == "client") {
                  Navigator.pushNamed(context, RoutesManager.clientHome);
                } else {
                  Navigator.pushNamed(context, RoutesManager.freelancerHome);
                }
                showTemporaryMessage(
                  context,
                  local.profileUpdateSuccess,
                  MessageType.success,
                );
              }
            }, builder: (context, state) {

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        UserAvatar(
                          userName:  widget.userInfoEntity.fullName,
                          radius: 50.r,
                          imagePath: _pickedImagePath ??
                              SharedPrefHelper.getString(
                                  StringsManager.profileImageKey),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              decoration: const BoxDecoration(

                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.camera_alt,
                                size: 20.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    local.userName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                      hintText: local.enterUserName,
                      keyboardType: TextInputType.name,
                      textEditingController: context
                          .read<UpdateUserProfileViewModel>()
                          .fullNameController),
                  SizedBox(height: 16.h),
                  Text(
                    local.emailAddress,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                      isEnable:  false,
                      hintText: local.enterEmailAddress,
                      keyboardType: TextInputType.name,
                      textEditingController: context
                          .read<UpdateUserProfileViewModel>()
                          .emailController),
                  SizedBox(height: 16.h),
                  Text(
                    local.phoneNumber,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                      hintText: local.enterPhoneNumber,
                      keyboardType: TextInputType.name,
                      textEditingController: context
                          .read<UpdateUserProfileViewModel>()
                          .phoneNumberController),
                  SizedBox(height: 50.h),
                  CustomButton(
                    title: local.save,
                    ontap: () {
                      final vm = context.read<UpdateUserProfileViewModel>();

                      if (vm.fullNameController.text.isEmpty ||
                          vm.emailController.text.isEmpty) {
                        showTemporaryMessage(
                          context,
                          local.fillRequiredFields,
                          MessageType.error,
                        );
                        return;
                      }

                      vm.updateUserInfo(
                        widget.userInfoEntity.id,
                        vm.fullNameController.text,
                        vm.emailController.text,
                        vm.phoneNumberController.text,
                        _pickedImagePath ??
                            widget.userInfoEntity.profileImage ??
                            SharedPrefHelper.getString(
                                StringsManager.profileImageKey)!,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }));
  }
}