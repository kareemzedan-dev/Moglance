import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_order_view_model.dart/get_order_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_order_view_model.dart/get_order_view_model_states.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/order_states_card.dart';
import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import 'empty_state_animation.dart';

class OrderStatusCardListView extends StatelessWidget {
  const OrderStatusCardListView({
    super.key,
    required this.animationPath,
    required this.message,
    required this.filter,
    required this.userId,
    required this.role,
  });

  final String animationPath;
  final String message;
  final OrderStatusFilter filter;
  final String userId;
  final String role;

  List<OrderEntity> _filterOrders(List<OrderEntity> orders, OrderStatusFilter filter) {
    final filtered = orders.where((order) {
      switch (filter) {
        case OrderStatusFilter.pending:
          return order.status == OrderStatus.Pending ||
              order.status == OrderStatus.Accepted ||
              order.status == OrderStatus.Paid;
        case OrderStatusFilter.inProgress:
          return order.status == OrderStatus.InProgress;
        case OrderStatusFilter.completed:
          return order.status == OrderStatus.Completed;
        case OrderStatusFilter.cancelled:
          return order.status == OrderStatus.Cancelled;
      }
    }).toList();

    // ✅ ترتيب حسب الأحدث أولاً
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    print('🎯 Filter: $filter - Orders count: ${orders.length} - Filtered: ${filtered.length}');
    for (var order in filtered) {
      print('🎯 Order: ${order.id} - Status: ${order.status}');
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderViewModel, GetOrderViewModelStates>(
      buildWhen: (previous, current) {

        return current is GetOrderViewModelStatesSuccess ||
            current is GetOrderViewModelStatesLoading ||
            current is GetOrderViewModelStatesError;
      },
      builder: (context, state) {
        print('🔄 OrderStatusCardListView rebuilding - State: ${state.runtimeType}');

        if (state is GetOrderViewModelStatesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetOrderViewModelStatesError) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
              const SizedBox(height: 20),
              Text("تحقق من اتصالك بالانترنت"),
            ],
          ));
        } else if (state is GetOrderViewModelStatesSuccess) {
          final filteredOrders = _filterOrders(state.orderEntity, filter);

          if (filteredOrders.isEmpty) {
            return Center(
              child: EmptyStateAnimation(
                animationPath: animationPath,
                message: message,
              ),
            );
          }

          return ListView.separated(
            itemCount: filteredOrders.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              print('📦 Building card for order: ${order.id} - Status: ${order.status}');

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: OrderStatesCard(order: order),
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

enum OrderStatusFilter { pending, inProgress, completed, cancelled }
