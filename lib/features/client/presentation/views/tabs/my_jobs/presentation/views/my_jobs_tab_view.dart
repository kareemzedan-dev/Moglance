import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_order_view_model.dart/get_order_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/order_status_card_list_view.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../core/components/dismissible_error_card.dart';
import '../../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../view_model/delete_order_view_model/delete_order_states.dart';
import '../view_model/delete_order_view_model/delete_order_view_model.dart';
import '../view_model/get_order_view_model.dart/get_order_view_model_states.dart';


class MyJobsTabView extends StatelessWidget {
  MyJobsTabView({super.key});
  final String userId = SharedPrefHelper.getString("id")!;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetOrderViewModel>(
          create: (_) => getIt<GetOrderViewModel>()..loadAndSubscribeOrders(userId, "client"),
        ),
        BlocProvider<DeleteOrderViewModel>(
          create: (_) => getIt<DeleteOrderViewModel>(),
        ),
      ],
      child: BlocListener<DeleteOrderViewModel, DeleteOrderStates>(
        listener: (context, state) {
          if (state is DeleteOrderSuccessState) {
            context.read<GetOrderViewModel>().loadAndSubscribeOrders(userId, "client");
          }
          if (state is DeleteOrderErrorState) {
            showTemporaryMessage(context, "Failed to delete order", MessageType.error);
          }
        },
        child: BlocBuilder<GetOrderViewModel, GetOrderViewModelStates>(
          builder: (context, state) {
            List<OrderEntity> orders = [];
            if (state is GetOrderViewModelStatesSuccess) {
              orders = state.orderEntity;
            }

            int pendingCount =
                orders.where((o) => o.status == OrderStatus.Accepted || o.status == OrderStatus.Paid || o.status == OrderStatus.Pending).length;
            int inProgressCount =
                orders.where((o) => o.status == OrderStatus.InProgress || o.status == OrderStatus.Waiting).length;
            int completedCount =
                orders.where((o) => o.status == OrderStatus.Completed).length;
            int cancelledCount =
                orders.where((o) => o.status == OrderStatus.Cancelled).length;

            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,

                  shape: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  title: Text(
                    local.manageOrders,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize:   Size.fromHeight(60.h),
                    child: TabBar(


                      labelColor: ColorsManager.primary,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                      unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                      indicatorColor: ColorsManager.primary,
                      indicatorWeight: 4,
                      tabs: [
                        _buildTabWithBadge(local.pending, pendingCount),
                        _buildTabWithBadge(local.inProgress, inProgressCount),
                        _buildTabWithBadge(local.completed, completedCount),
                        _buildTabWithBadge(local.cancelled, cancelledCount),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    OrderStatusCardListView(
                      animationPath: "assets/lotties/Loading.json",
                      message: local.no_pending_orders_yet,
                      filter: OrderStatusFilter.pending,
                      userId: userId,
                      role: "client",
                    ),
                    OrderStatusCardListView(
                      animationPath: "assets/lotties/Progress.json",
                      message: local.no_orders_in_progress,
                      filter: OrderStatusFilter.inProgress,
                      userId: userId,
                      role: "client",
                    ),
                    OrderStatusCardListView(
                      animationPath: "assets/lotties/Success.json",
                      message: local.no_completed_orders,
                      filter: OrderStatusFilter.completed,
                      userId: userId,
                      role: "client",
                    ),
                    OrderStatusCardListView(
                      animationPath: "assets/lotties/cancelled.json",
                      message: local.no_cancelled_orders,
                      filter: OrderStatusFilter.cancelled,
                      userId: userId,
                      role: "client",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabWithBadge(String title, int count) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Tab(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
        ),

        Positioned(
          top: -10,
          right: -15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: ColorsManager.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: BoxConstraints(
              minWidth: 20.w,
              minHeight: 20.h,
            ),
            child: Center(
              child: Text(
                '$count',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
