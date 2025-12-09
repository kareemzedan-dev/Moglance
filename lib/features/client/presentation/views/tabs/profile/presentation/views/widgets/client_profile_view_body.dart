import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/client/presentation/views/tabs/profile/presentation/views/widgets/account_item_row.dart';
import 'package:taskly/features/profile/presentation/widgets/user_info_section.dart';
import 'package:taskly/features/client/presentation/views/tabs/profile/presentation/views/widgets/user_info_section_shimmer.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model_states.dart';
import 'package:taskly/features/shared/presentation/views/widgets/language_bottom_sheet_content.dart';
import 'package:taskly/features/shared/presentation/views/widgets/profile_section.dart';
import 'package:taskly/features/shared/presentation/views/widgets/theme_bottom_sheet_content.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../core/helper/language_notifier.dart';

class ClientProfileViewBody extends StatefulWidget {
  const ClientProfileViewBody({super.key});

  @override
  State<ClientProfileViewBody> createState() => _ClientProfileViewBodyState();
}

class _ClientProfileViewBodyState extends State<ClientProfileViewBody> {
  String _currentLanguage = "English";
  String _currentTheme = "Light";
  dynamic _userInfo;
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            BlocProvider(
              create: (context) => getIt<ProfileViewModel>()
                ..getUserInfo(
                  SharedPrefHelper.getString(StringsManager.idKey)!,
                  SharedPrefHelper.getString(StringsManager.roleKey)!,
                ),
              child: BlocBuilder<ProfileViewModel, ProfileViewModelStates>(
                builder: (context, state) {
                  if (state is ProfileViewModelStatesLoading) {
                    return const UserInfoSectionShimmer();
                  } else if (state is ProfileViewModelStatesSuccess) {

                    _userInfo = state.userInfoEntity;
                    return UserInfoSection(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesManager.userAccountView,
                          arguments: state.userInfoEntity,
                        );
                      },
                      rating: state.userInfoEntity.rating!,
                    );
                  } else if (state is ProfileViewModelStatesError) {
                    return Text(state.message);
                  }
                  return const UserInfoSectionShimmer();
                },
              ),
            ),

            SizedBox(height: 40.h),

            /// ✅ Support Section
            ProfileSection(
              title: local.support,
              children: [
                AccountItemRow(
                  image: Assets.assetsImagesTechSupport5109502,
                  text: local.technical_support,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.technicalSupportView,
                    );
                  },
                ),
              ],
            ),
            ProfileSection(
              title: local.workSection,
              children: [
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap:   () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.reviewsView,
                      arguments: {
                        'userId': _userInfo.id,
                        'role': 'client',
                        'userName': _userInfo.fullName,
                        'userRating': _userInfo.rating,
                        'userImage': _userInfo.profileImage,
                      },
                    );
                  },
                  child: AccountItemRow(
                    image: Assets.assetsImagesStar967444,
                    text: local.reviewsRatings,
                  ),
                ),
              ],
            ),
            /// ✅ Account Section
            ProfileSection(
              title: local.account,
              children: [
                AccountItemRow(
                  image: Assets.assetsImagesInternet2889312,
                  text: local.language,
                  onTap: () async {
                    final selected = await showModalBottomSheet<String>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      builder: (context) {
                        return LanguageBottomSheetContent(
                          initialLanguage: context.read<LanguageNotifier>().currentLanguage,
                        );
                      },
                    );

                    if (selected != null) {
                      setState(() {
                        _currentLanguage = selected;
                      });
                    }
                  },
                ),

                SizedBox(height: 10.h),
                AccountItemRow(
                  image: Assets.assetsImagesCahngePassword,
                  text: local.change_password,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.changePasswordView,
                    );
                  },
                ),
              ],
            ),

            /// ✅ Settings Section
            ProfileSection(
              title: local.settings,
              children: [
                AccountItemRow(
                  image: Assets.assetsImagesAccount3166234,
                  text: local.privacy_policy,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.privacyPolicyView,
                    );
                  },
                ),
                // SizedBox(height: 10.h),
                // AccountItemRow(
                //   image: Assets.assetsImagesDocument10103871,
                //   text: local.terms_conditions,
                // ),
              ],
            ),
SizedBox(height: 20.h,),
            /// ✅ Logout Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: InkWell(
                onTap: () {
                  SharedPrefHelper.clear();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesManager.splash,
                        (route) => false,
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Colors.red),
                    const SizedBox(width: 12),
                    Text(
                      local.logout,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
