import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
 import 'package:taskly/features/shared/domain/use_cases/orders/orders_use_case.dart';
import 'package:taskly/features/shared/presentation/manager/subscribe_to_order_record_view_model/subscribe_to_order_record_states.dart';
import '../../../../../config/l10n/app_localizations.dart';
import '../../../domain/entities/order_entity/order_entity.dart';

@injectable
class SubscribeOrdersRecordViewModel extends Cubit<OrderViewModelState> {
  final OrdersUseCase subscribeOrderUseCase;
  StreamSubscription? _subscription;

  // Map للاحتفاظ بالحالات التي تم إرسال الإشعار لها بالفعل لكل order
  final Map<String, Set<OrderStatus>> _sentNotifications = {};

  SubscribeOrdersRecordViewModel({required this.subscribeOrderUseCase})
      : super(OrderInitial());

  void subscribe(String orderId) {
    emit(OrderLoading());
    _subscription?.cancel();
    _subscription = subscribeOrderUseCase
        .callSubscribeToOrder(orderId)
        .listen((order) {
      print("Realtime update received: ${order.id} - ${order.status}");

      emit(OrderSuccess(order));
    }, onError: (error) {
      print("Error in subscription: $error");
      emit(OrderError(error.toString()));
    });
  }

  String getAdminMessage(OrderEntity order, AppLocalizations local) {
    switch (order.status) {
      case OrderStatus.Pending:
        return local.orderPending;
      case OrderStatus.Accepted:
        return local.orderAccepted;
      case OrderStatus.Paid:
        return local.orderPaid;
      case OrderStatus.InProgress:
        return local.orderInProgress;
      case OrderStatus.Waiting:
        return local.orderWaiting;
      case OrderStatus.Completed:
        return local.orderCompleted;
      case OrderStatus.Cancelled:
        return local.orderCancelled;
      default:
        return local.orderUnknown;
    }
  }

  String? getActionButtonText(OrderEntity order, String currentUserId, AppLocalizations local) {
    switch (order.status) {
      case OrderStatus.Pending:
        return null;
      case OrderStatus.Accepted:
        if (currentUserId == order.clientId) {
          return local.payNowButton(order.budget.toString());

        }
        return null;
      case OrderStatus.InProgress:
        if (currentUserId == order.freelancerId) return local.submitDeliveryButton;
        return null;
      case OrderStatus.Waiting:
        if (currentUserId == order.clientId) return local.workReceivedButton;

        case OrderStatus.Completed:
        if (currentUserId == order.freelancerId) return local.rateClient;
        if (currentUserId == order.clientId) return local.rateFreelancer;

        return null;
      default:
        return null;
    }
  }

  bool shouldShowButton(OrderEntity order, String currentUserId, AppLocalizations local) {
    return getActionButtonText(order, currentUserId, local) != null;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
