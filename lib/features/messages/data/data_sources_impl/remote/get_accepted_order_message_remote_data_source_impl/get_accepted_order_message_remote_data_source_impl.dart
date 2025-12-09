import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/shared/data/models/order_dm/order_dm.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../../core/utils/network_utils.dart';
import '../../../../../welcome/presentation/cubit/welcome_states.dart';
import '../../../data_sources/remote/get_accepted_order_message_remote_data_source/get_accepted_order_message_remote_data_source.dart';

@Injectable(as: GetAcceptedOrderMessageRemoteDataSource)
class GetAcceptedOrderMessageRemoteDataSourceImpl
    extends GetAcceptedOrderMessageRemoteDataSource {
  final SupabaseService supabaseService;

  GetAcceptedOrderMessageRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, List<OrderEntity>>> getAcceptedOrderMessages(
      String userId,
      {UserRole? role}) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }

      final column = role == UserRole.freelancer ? 'freelancer_id' : 'client_id';
      final response = await supabaseService.supabaseClient
          .from('orders')
          .select()
          .eq(column, userId)
          .inFilter('status', [
        'Accepted',
        'Paid',
        'In Progress',
        'Waiting',
        'Completed',
        'Cancelled'
      ]);

      final orders = <OrderEntity>[];

      for (final orderData in response) {
        final order = OrderDm.fromJson(orderData).toEntity();

        final lastMsgData = await supabaseService.supabaseClient
            .from('messages')
            .select()
            .eq('order_id', order.id)
            .order('created_at', ascending: false)
            .limit(1)
            .maybeSingle();

        if (lastMsgData != null) {
          orders.add(order.copyWith(
            lastMessage: lastMsgData['content'] as String?,
            lastMessageTime: DateTime.tryParse(lastMsgData['created_at'] ?? ''),
          ));
        } else {
          orders.add(order);
        }
      }

      return Right(orders);
    } catch (e, st) {
      print("Error fetching accepted messages: $e\n$st");
      return Left(ServerFailure(e.toString()));
    }
  }

  // ✅ Stream مصحح ومطابق لـ Supabase SDK
  Stream<List<OrderEntity>> subscribeToAcceptedOrders(String userId, {UserRole? role}) {
    final column = role == UserRole.freelancer ? 'freelancer_id' : 'client_id';
    final statuses = [
      'Accepted',
      'Paid',
      'In Progress',
      'Waiting',
      'Completed',
      'Cancelled'
    ];

    final ordersStream = supabaseService.supabaseClient
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq(column, userId)
        .map((rows) => rows
        .where((row) => statuses.contains(row['status']))
        .map((row) => OrderDm.fromJson(row).toEntity())
        .toList());

    final messagesStream = supabaseService.supabaseClient
        .from('messages')
        .stream(primaryKey: ['id']);

    // ✅ Combine latest orders + messages with correct typing
    return Rx.combineLatest2<List<OrderEntity>, List<Map<String, dynamic>>,
        List<OrderEntity>>(
      ordersStream,
      messagesStream,
          (orders, messagesList) {
        return orders.map((order) {
          final orderMessages = messagesList
              .where((m) => m['order_id'] == order.id)
              .toList()
            ..sort((a, b) =>
                (b['created_at'] as String).compareTo(a['created_at'] as String));

          if (orderMessages.isNotEmpty) {
            final last = orderMessages.first;
            return order.copyWith(
              lastMessage: last['content'] as String?,
              lastMessageTime: DateTime.tryParse(last['created_at'] ?? ''),
            );
          }

          return order;
        }).toList();
      },
    );
  }
}
