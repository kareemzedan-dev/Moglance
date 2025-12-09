import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:taskly/features/messages/data/models/message_model.dart';

import '../../../data_sources/remote/subscribe_to_unread_messages_remote_data_source/subscribe_to_unread_messages_remote_data_source.dart';
@Injectable(as: SubscribeToUnreadMessagesRemoteDataSource)
class SubscribeToUnreadMessagesRemoteDataSourceImpl
    implements SubscribeToUnreadMessagesRemoteDataSource {
  final SupabaseClient client;

  SubscribeToUnreadMessagesRemoteDataSourceImpl(this.client);

  @override
  Stream<List<MessageEntity>> getUnreadMessagesStream(String currentUserId) {
    try {
      return client
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('receiver_id', currentUserId)
      // ممكن لا تدعم is_ أو filter على الـ stream بناءً على النسخة، فبنفلتر هنا:
          .map((data) {
        // data عادة List<Map<String,dynamic>> — نفلتر بالـ client
        final list = data
            .where((json) => json['seen_at'] == null) // <- هنا الفلتر
            .map((json) => MessageModel.fromJson(json).toEntity())
            .toList();
        return list;
      });
    } catch (e) {
      print('❌ Error in getUnreadMessagesStream: $e');
      return const Stream.empty();
    }
  }
}
