import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/cache/shared_preferences.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../data/models/favorite_order_model/favorite_order_model.dart';
import '../../view_model/add_favorite_order_view_model/add_favorite_order_view_model.dart';
import '../../view_model/get_favorite_order_view_model/get_favorite_order_view_model.dart';
import '../../view_model/remove_favorite_order_view_model/remove_favorite_order_view_model.dart';
import 'favourite_order_list.dart';

class FavouriteOrdersViewBody extends StatefulWidget {
  const FavouriteOrdersViewBody({super.key});

  @override
  State<FavouriteOrdersViewBody> createState() => _FavouriteOrdersViewBodyState();

}
final addFavViewModel = getIt<AddFavoriteOrderViewModel>();

class _FavouriteOrdersViewBodyState extends State<FavouriteOrdersViewBody> {
  @override
  void initState() {
    super.initState();

    final savedJsonList = SharedPrefHelper.getStringList('favoriteOrders') ?? [];
    final savedFavorites = savedJsonList.map((jsonStr) {
      return FavoriteOrderModel.fromJson(jsonDecode(jsonStr));
    }).toList();

    // خليه يتحمل على نفس النسخة اللي في BlocProvider
    final addFavViewModel = getIt<AddFavoriteOrderViewModel>();
    addFavViewModel.loadFavorites(savedFavorites);
  }
  @override
  Widget build(BuildContext context) {



    return  Padding(padding: const EdgeInsets.all(16),child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<GetFavoriteOrderViewModel>()),
            BlocProvider.value(value: addFavViewModel),
            BlocProvider(create: (context) => getIt<RemoveFavoriteOrderViewModel>()),
          ],
          child: Expanded(child: FavouriteOrderList(addFavViewModel: addFavViewModel)),
        )

      ],)
    );
  }
}