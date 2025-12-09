 import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';

abstract class SubscribeToMessagesRemoteDataSource {
  Stream<(MessageEntity, String)> subscribeToMessages(String orderId, String currentUserId, String otherUserId);
 }