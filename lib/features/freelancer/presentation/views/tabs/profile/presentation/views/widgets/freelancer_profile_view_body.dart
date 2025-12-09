import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/features/client/presentation/views/tabs/profile/presentation/views/widgets/account_item_row.dart';
import 'package:taskly/features/profile/presentation/widgets/user_info_section.dart';
import 'package:taskly/features/shared/presentation/views/widgets/language_bottom_sheet_content.dart';
import 'package:taskly/features/shared/presentation/views/widgets/profile_section.dart';
import 'package:taskly/features/shared/presentation/views/widgets/theme_bottom_sheet_content.dart';
import '../../../../../../../../../core/cache/shared_preferences.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../../core/helper/language_notifier.dart';
import '../../../../../../../../../core/utils/strings_manager.dart';
import '../../../../../../../../client/presentation/views/tabs/profile/presentation/views/widgets/user_info_section_shimmer.dart';
import '../../../../../../../../profile/presentation/manager/profile_view_model/profile_view_model.dart';
import '../../../../../../../../profile/presentation/manager/profile_view_model/profile_view_model_states.dart';

class FreelancerProfileViewBody extends StatefulWidget {
  const FreelancerProfileViewBody({super.key});

  @override
  State<FreelancerProfileViewBody> createState() =>
      _FreelancerProfileViewBodyState();
}
class _FreelancerProfileViewBodyState extends State<FreelancerProfileViewBody> {
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
                 "freelancer",
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
                    return Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("تحقق من اتصالك بالانترنت"),
                      ],
                    ));
                  }
                  return const UserInfoSectionShimmer();
                },
              ),
            ),

            SizedBox(height: 40.h),
            ProfileSection(
              title: local.dashboardSection,
              children: [
                AccountItemRow(
                  image: Assets.assetsImagesWallet2527857,
                  text: local.earnings,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.freelancerEarningView,
                    );
                  },
                ),
                SizedBox(height: 10.h),
                AccountItemRow(
                  image: Assets.assetsImagesWithdrawal8211181,
                  text: local.withdrawBalance,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.requestWithdrawalView,
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
                        'role': 'freelancer',
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


            // ProfileSection(
            //   title: local.supportSection,
            //   children: [
            //     AccountItemRow(
            //       image: Assets.assetsImagesTechSupport5109502,
            //       text: local.technicalSupport,
            //       onTap: () {
            //         Navigator.pushNamed(
            //           context,
            //           RoutesManager.technicalSupportView,
            //         );
            //       },
            //     ),
            //   ],
            // ),

            ProfileSection(
              title: local.accountSection,
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
                // AccountItemRow(
                //   image: Assets.assetsImagesBrushes3450037,
                //   text: local.theme,
                //   onTap: () async {
                //     final selectedTheme = await showModalBottomSheet<String>(
                //       context: context,
                //       backgroundColor: Colors.transparent,
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.vertical(
                //           top: Radius.circular(12),
                //         ),
                //       ),
                //       builder: (context) {
                //         return ThemeBottomSheetContent(
                //           initialTheme: _currentTheme,
                //         );
                //       },
                //     );
                //
                //     if (selectedTheme != null) {
                //       setState(() {
                //         _currentTheme = selectedTheme;
                //       });
                //     }
                //   },
                // ),
                SizedBox(height: 10.h),

                AccountItemRow(
                  image: Assets.assetsImagesCahngePassword,
                  text: local.changePassword,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.changePasswordView,
                    );
                  },
                ),
              ],
            ),
            ProfileSection(
              title: local.settingsSection,
              children: [
                SizedBox(height: 10.h),
                AccountItemRow(
                  image: Assets.assetsImagesAccount3166234,
                  text: local.privacyPolicy,
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
                //   text: local.termsConditions,
                // ),
              ],
            ),
            SizedBox(height: 20.h),
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
                  Navigator.pushNamed(context, RoutesManager.splash);
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