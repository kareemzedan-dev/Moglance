import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/freelancer_work_card.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../core/utils/assets_manager.dart';
import '../../view_model/add_favorite_order_view_model/add_favorite_order_view_model.dart';
import '../../view_model/freelancer_private_orders_view_model/freelancer_private_orders_view_model_states.dart';
import 'freelancer_work_card_shimmer.dart';

class FreelancerPrivateOrdersList extends StatelessWidget {
  final FreelancerPrivateOrdersViewModelStates state;
  final AddFavoriteOrderViewModel addFavViewModel;

  const FreelancerPrivateOrdersList({super.key, required this.state, required this.addFavViewModel});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (state is FreelancerPrivateOrdersViewModelStatesLoading) {
      return const FreelancerWorkCardShimmer(
      );
    } else if (state is FreelancerPrivateOrdersViewModelStatesSuccess) {
      final orders = (state as FreelancerPrivateOrdersViewModelStatesSuccess).orders;

      if (orders.isNotEmpty) {

        orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }

      if (orders.isEmpty) {
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
                      local.no_private_orders_available,
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
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(color: Colors.grey.shade300, thickness: 1.w),
        ),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FreelancerWorkCard(
              order: order,
              addFavViewModel: addFavViewModel,
              offeredOrderIds: (state as FreelancerPrivateOrdersViewModelStatesSuccess).offeredOrderIds,
            ),
          );
        },
      );


    }
    else if (state is FreelancerPrivateOrdersViewModelStatesError) {
      return const FreelancerWorkCardShimmer();
    }
    return Container();
  }
}
