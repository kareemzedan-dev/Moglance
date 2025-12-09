import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/messages/data/data_sources/remote/subscribe_to_messages_remote_data_source/subscribe_to_messages_remote_data_source.dart';
import 'package:taskly/features/messages/data/models/message_model.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';

@Injectable(as: SubscribeToMessagesRemoteDataSource)
class SubscribeToMessagesRemoteDataSourceImpl implements SubscribeToMessagesRemoteDataSource {
  final SupabaseService supabaseService;

  SubscribeToMessagesRemoteDataSourceImpl({required this.supabaseService});

  @override
  Stream<(MessageEntity, String)> subscribeToMessages(
      String orderId,
      String currentUserId,
      String otherUserId,
    ) {
    final client = supabaseService.supabaseClient;
    final controller = StreamController<(MessageEntity, String)>();

    final channel = client.channel(
      'messages:order_$orderId',
      opts: const RealtimeChannelConfig(),
    );

    void handleRecord(Map<String, dynamic>? record, String eventType) {
      if (record == null) return;

      // فلترة على sender و receiver
      if (!((record['sender_id'] == currentUserId && record['receiver_id'] == otherUserId) ||
          (record['sender_id'] == otherUserId && record['receiver_id'] == currentUserId))) {
        return; // تجاهل الرسائل اللي مش بين الاثنين
      }

      final message = MessageModel.fromJson(record);
      controller.add((message, eventType));
    }

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'order_id',
        value: orderId,
      ),
      callback: (payload) => handleRecord(payload.newRecord, 'INSERT'),
    );

    channel.onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'order_id',
        value: orderId,
      ),
      callback: (payload) => handleRecord(payload.newRecord, 'UPDATE'),
    );

    channel.onPostgresChanges(
      event: PostgresChangeEvent.delete,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'order_id',
        value: orderId,
      ),
      callback: (payload) => handleRecord(payload.oldRecord, 'DELETE'),
    );

    channel.subscribe();

    controller.onCancel = () async {
      await channel.unsubscribe();
    };

    return controller.stream;
  }
}
