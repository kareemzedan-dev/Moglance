import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/use_cases/get_admin_messages_use_case/get_admin_messages_use_case.dart';
import '../../../domain/use_cases/subscribe_to_admin_messages_use_case/subscribe_to_admin_messages_use_case.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chat_with_admin_state.dart';


@injectable
class ChatWithAdminViewModel extends Cubit<ChatWithAdminStates> {
  final GetAdminMessagesUseCase getAdminMessagesUseCase;
  final SubscribeToAdminMessagesUseCase subscribeToAdminMessagesUseCase;

  List<MessageEntity> messages = [];
  RealtimeChannel? _channel;

  ChatWithAdminViewModel(
      this.getAdminMessagesUseCase, this.subscribeToAdminMessagesUseCase)
      : super(ChatWithAdminInitial());

  Future<void> loadMessagesAndSubscribe(String currentUserId) async {
    emit(ChatWithAdminLoading());

    try {
      // جلب الرسائل القديمة
      final result = await getAdminMessagesUseCase.getAdminMessages(currentUserId);
      result.fold(
            (failure) => emit(ChatWithAdminError(failure.message)),
            (oldMessages) {
          messages = oldMessages;
          emit(ChatWithAdminLoaded(List.from(messages)));
        },
      );

      // الاشتراك في الرسائل الجديدة
      _channel = await subscribeToAdminMessagesUseCase.subscribeToAdminMessages(
        currentUserId,
            (msg, action) {
          final currentMessages = List<MessageEntity>.from(messages);
          if (!currentMessages.any((m) => m.id == msg.id)) {
            currentMessages.add(msg);
            messages = currentMessages; // حدث الحالة الداخلية
            emit(ChatWithAdminLoaded(currentMessages));
          }
        },
      );

    } catch (e) {
      emit(ChatWithAdminError("Something went wrong"));
    }
  }

  void unsubscribe() {
    _channel?.unsubscribe();
    _channel = null;
    messages.clear();
    emit(ChatWithAdminInitial());
  }
}
