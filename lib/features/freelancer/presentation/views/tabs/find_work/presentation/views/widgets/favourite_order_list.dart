import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/get_favorite_order_view_model/get_favorite_order_states.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/get_favorite_order_view_model/get_favorite_order_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/get_favourite_order_details_view_model/get_favourite_order_details_states.dart';

import '../../view_model/add_favorite_order_view_model/add_favorite_order_view_model.dart';
import '../../view_model/get_favourite_order_details_view_model/get_favourite_order_details_view_model.dart';
import 'freelancer_work_card.dart';

class FavouriteOrderList extends StatelessWidget {
  const FavouriteOrderList({super.key, required this.addFavViewModel});

  final AddFavoriteOrderViewModel addFavViewModel; // ✅ أضف هذا

  @override
  Widget build(BuildContext context) {
    final userId = SharedPrefHelper.getString(StringsManager.idKey)!;

    return BlocProvider(
      create: (context) => getIt<GetFavoriteOrderViewModel>()..getFavoritesByUser(userId),
      child: BlocBuilder<GetFavoriteOrderViewModel, GetFavoriteOrderStates>(
        builder: (context, state) {
          if (state is GetFavoriteOrderLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetFavoriteOrderSuccessState) {
            if (state.favoriteOrders.isEmpty) {
              return const Center(child: Text("لا يوجد عناصر مفضلة بعد"));
            }

            final orderIds = state.favoriteOrders.map((f) => f.orderId).toList();

            return BlocProvider(
              create: (context) => getIt<GetFavouriteOrderDetailsViewModel>()
                ..getFavouriteOrderDetails(orderIds),
              child: BlocBuilder<GetFavouriteOrderDetailsViewModel, GetFavouriteOrderDetailsStates>(
                builder: (context, detailsState) {
                  if (detailsState is GetFavouriteOrderDetailsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (detailsState is GetFavouriteOrderDetailsSuccessState) {

                    // ✅ حدث الـ AddFavoriteOrderViewModel بعد تحميل التفاصيل
                    for (var order in detailsState.orders) {
                      final fav = state.favoriteOrders.firstWhere(
                            (f) => f.orderId == order.id,

                      );
                      addFavViewModel.loadFavorites([fav]);
                                        }

                    return ListView.separated(
                      itemCount: detailsState.orders.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: FreelancerWorkCard(
                          order: detailsState.orders[index],
                          addFavViewModel: addFavViewModel,
                          offeredOrderIds: [],
                        ),
                      ),
                    );
                  } else if (detailsState is GetFavouriteOrderDetailsErrorState) {
                    return Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
                        const SizedBox(height: 20),
                        Text("تحقق من اتصالك بالانترنت"),
                      ],
                    ));
                  }
                  return const SizedBox.shrink();
                },
              ),
            );
          } else if (state is GetFavoriteOrderErrorState) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
                const SizedBox(height: 20),
                Text("تحقق من اتصالك بالانترنت"),
              ],
            ));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
