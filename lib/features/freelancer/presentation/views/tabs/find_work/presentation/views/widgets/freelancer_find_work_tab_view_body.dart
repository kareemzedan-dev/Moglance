import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/components/custom_tab_bar.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/user_info_home_header.dart'
    as header;
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/search_bar_with_favorite.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model_states.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../view_model/add_favorite_order_view_model/add_favorite_order_view_model.dart';
import '../../view_model/remove_favorite_order_view_model/remove_favorite_order_view_model.dart';
import '../../view_model/freelancer_private_orders_view_model/freelancer_private_orders_view_model.dart';
import '../../view_model/freelancer_private_orders_view_model/freelancer_private_orders_view_model_states.dart';
import '../../view_model/freelancer_public_order_view_model/freelancer_public_order_states.dart';
import '../../view_model/freelancer_public_order_view_model/freelancer_public_order_view_model.dart';
import '../../../../../../../data/models/favorite_order_model/favorite_order_model.dart';
import 'freelancer_private_list_view.dart';
import 'freelancer_public_orders_list.dart';

class FreelancerHomeTabViewBody extends StatefulWidget {
  const FreelancerHomeTabViewBody({super.key});

  @override
  State<FreelancerHomeTabViewBody> createState() =>
      _FreelancerHomeTabViewBodyState();
}

class _FreelancerHomeTabViewBodyState extends State<FreelancerHomeTabViewBody> {
  late final ProfileViewModel _freelancerInfoViewModel;
  late final FreelancerPublicOrdersViewModel _pendingOrdersViewModel;
  late final FreelancerPrivateOrdersViewModel _privateOrderViewModel;
  late final AddFavoriteOrderViewModel _addFavoriteOrderViewModel;
  late final RemoveFavoriteOrderViewModel _removeFavoriteOrderViewModel;

  String userId = SharedPrefHelper.getString("id")!;

  @override
  void initState() {
    super.initState();

    _freelancerInfoViewModel = getIt<ProfileViewModel>()
      ..getUserInfo(userId, "freelancer");

    _pendingOrdersViewModel = getIt<FreelancerPublicOrdersViewModel>()
      ..fetchAndSubscribePendingOrders();

    _privateOrderViewModel = getIt<FreelancerPrivateOrdersViewModel>()
      ..fetchAndSubscribePrivateOrders(userId);

    _addFavoriteOrderViewModel = getIt<AddFavoriteOrderViewModel>();

    final savedJsonList = SharedPrefHelper.getStringList('favoriteOrders') ?? [];
    final savedFavorites = savedJsonList
        .map((jsonStr) => FavoriteOrderModel.fromJson(jsonDecode(jsonStr)))
        .toList();
    _addFavoriteOrderViewModel.loadFavorites(savedFavorites);

    _removeFavoriteOrderViewModel = getIt<RemoveFavoriteOrderViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final searchHintTexts = [
      local.search_for_private_orders,
      local.search_for_public_orders,
      local.search_for_favorite_orders,
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _freelancerInfoViewModel),
        BlocProvider.value(value: _pendingOrdersViewModel),
        BlocProvider.value(value: _privateOrderViewModel),
        BlocProvider.value(value: _addFavoriteOrderViewModel),
        BlocProvider.value(value: _removeFavoriteOrderViewModel),
      ],
      child: Builder(
        builder: (context) {
          return DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  header.UserInfoHomeHeader(),
                  SizedBox(height: 20.h),

                  /// FIXED — now context sees providers
                  SearchBarWithFavorite(
                    hintTexts: searchHintTexts,
                    onChanged: (query) {
                      context
                          .read<FreelancerPublicOrdersViewModel>()
                          .searchOrders(query);

                      context
                          .read<FreelancerPrivateOrdersViewModel>()
                          .searchOrders(query);
                    },
                  ),

                  SizedBox(height: 30.h),

                  BlocBuilder<FreelancerPublicOrdersViewModel,
                      FreelancerPublicOrdersState>(
                    builder: (context, publicState) {
                      final publicCount =
                          publicState is FreelancerPendingOrdersSuccess
                              ? publicState.pendingOrdersList.length
                              : 0;

                      return BlocBuilder<FreelancerPrivateOrdersViewModel,
                          FreelancerPrivateOrdersViewModelStates>(
                        builder: (context, privateState) {
                          final privateCount =
                              privateState
                                      is FreelancerPrivateOrdersViewModelStatesSuccess
                                  ? privateState.orders.length
                                  : 0;

                          return CustomTabBar(
                            tabs: [local.public_requests, local.private_requests],
                            numbers: [publicCount, privateCount],
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: 6.h),
                  Divider(color: Colors.grey.shade300, thickness: 1.w),

                  Expanded(
                    child: BlocBuilder<ProfileViewModel,
                        ProfileViewModelStates>(
                      builder: (context, state) {
                        if (state is ProfileViewModelStatesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (state is ProfileViewModelStatesError) {
                          return Center(child: Text(local.somethingWentWrong));
                        }

                        if (state is ProfileViewModelStatesSuccess) {
                          if (state.userInfoEntity.isVerified!) {
                            return TabBarView(
                              children: [
                                BlocBuilder<FreelancerPublicOrdersViewModel,
                                    FreelancerPublicOrdersState>(
                                  builder: (context, pendingState) {
                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        await context
                                            .read<
                                                FreelancerPublicOrdersViewModel>()
                                            .fetchAndSubscribePendingOrders();
                                      },
                                      child: FreelancerPublicOrdersList(
                                        state: pendingState,
                                        addFavViewModel:
                                            _addFavoriteOrderViewModel,
                                        viewModel: _pendingOrdersViewModel,
                                      ),
                                    );
                                  },
                                ),
                                BlocBuilder<
                                    FreelancerPrivateOrdersViewModel,
                                    FreelancerPrivateOrdersViewModelStates>(
                                  builder: (context, privateState) {
                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        await context
                                            .read<
                                                FreelancerPrivateOrdersViewModel>()
                                            .fetchAndSubscribePrivateOrders(
                                                userId);
                                      },
                                      child: FreelancerPrivateOrdersList(
                                        state: privateState,
                                        addFavViewModel:
                                            _addFavoriteOrderViewModel,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: ColorsManager.primary.withOpacity(0.1),
                                    border: Border.all(
                                      color: ColorsManager.primary
                                          .withOpacity(0.3),
                                      width: 1.w,
                                    ),
                                  ),
                                  child:
                                      Lottie.asset("assets/lotties/waiting.json"),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  local.account_under_verification,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
