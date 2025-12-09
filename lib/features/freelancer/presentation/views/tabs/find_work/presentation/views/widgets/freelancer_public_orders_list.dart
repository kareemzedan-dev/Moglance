import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/core/utils/assets_manager.dart';
 import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/freelancer_public_order_view_model/freelancer_public_order_states.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/freelancer_work_card.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../view_model/add_favorite_order_view_model/add_favorite_order_view_model.dart';
import '../../view_model/freelancer_public_order_view_model/freelancer_public_order_view_model.dart';
import 'freelancer_work_card_shimmer.dart';

class FreelancerPublicOrdersList extends StatelessWidget {
  final FreelancerPublicOrdersState state;
  final FreelancerPublicOrdersViewModel viewModel;


  const FreelancerPublicOrdersList({super.key,required this.viewModel ,  required this.state, required this.addFavViewModel});
  final AddFavoriteOrderViewModel addFavViewModel;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (state is FreelancerPendingOrdersLoading) {
      return const FreelancerWorkCardShimmer();
    } else if (state is FreelancerPendingOrdersSuccess) {
      final orders =
          (state as FreelancerPendingOrdersSuccess).pendingOrdersList;

      final sortedOrders = List<OrderEntity>.from(orders)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      if (sortedOrders.isEmpty) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Column(
                  children: [
                    Image.asset(Assets.assetsImagesNoOrder, width: 240.w, height: 240.h,),
                    SizedBox(height: 10.h),
                    Text(
                      local.no_public_orders_available   ,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }

      return ListView.separated(
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(color: Colors.grey.shade300, thickness: 1.w),
        ),
        itemCount: sortedOrders.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FreelancerWorkCard(
            order: sortedOrders[index],
            addFavViewModel: addFavViewModel,
            offeredOrderIds: viewModel.offeredOrderIds,
          ),

        ),

      );
    }
    else if (state is FreelancerPendingOrdersError) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
          const SizedBox(height: 20),
          Text("تحقق من اتصالك بالانترنت"),
        ],
      ));
    }
    return Container();
  }
}
