import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../entities/message_entity.dart';
import '../../repositories/messages_repos/subscribe_to_admin_messages_repo/subscribe_to_admin_messages_repo.dart';
@injectable
  class SubscribeToAdminMessagesUseCase {
    SubscribeToAdminMessagesUseCase(this.repository);
    final SubscribeToAdminMessagesRepo repository;
  Future<RealtimeChannel> subscribeToAdminMessages(      String currentUserId,
      void Function(MessageEntity message, String action) onChange,){
    return repository.subscribeToAdminMessages(currentUserId, onChange);
  }
}