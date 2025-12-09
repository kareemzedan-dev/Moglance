import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/entities/message_entity.dart';

abstract class SubscribeToAdminMessagesRemoteDataSource {
  Future<RealtimeChannel> subscribeToAdminMessages(      String currentUserId,
      void Function(MessageEntity message, String action) onChange,);
}