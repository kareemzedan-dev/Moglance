import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../entities/message_entity.dart';

abstract class SubscribeToAdminMessagesRepo {
  Future<RealtimeChannel> subscribeToAdminMessages(      String currentUserId,
      void Function(MessageEntity message, String action) onChange,);
}