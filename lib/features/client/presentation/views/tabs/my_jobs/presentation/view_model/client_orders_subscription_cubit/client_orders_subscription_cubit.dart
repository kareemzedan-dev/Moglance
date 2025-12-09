import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/di/di.dart';
import '../get_order_view_model.dart/get_order_view_model.dart';

@injectable
class ClientOrdersSubscriptionCubit extends Cubit<void> {
  ClientOrdersSubscriptionCubit() : super(null);

  Future<void> init(String userId) async {
    print("🔔 ClientOrdersSubscriptionCubit INIT for → $userId");

    final vm = getIt<GetOrderViewModel>();

    // Load existing orders (no subscription)
    final orders = await vm.loadOrdersOnce(userId, "client");

    print("📦 Found ${orders.length} orders for offer subscription");

    // Subscribe each order to offers realtime
    for (var o in orders) {
      print("📡 Subscribing to offers for order → ${o.id}");
      vm.subscribeToOffers(orderId: o.id);
    }
  }
}
