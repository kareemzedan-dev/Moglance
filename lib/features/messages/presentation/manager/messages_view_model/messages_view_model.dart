import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/presentation/manager/mark_message_as_read_view_model/mark_message_as_read_view_model.dart';
import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../core/di/di.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/use_cases/get_order_messages_use_case/get_order_messages_use_case.dart';
import '../../../domain/use_cases/subscribe_to_messages_use_case/subscribe_to_messages_use_case.dart';
import 'messages_view_model_states.dart';

typedef OnConversationUpdated = void Function(String orderId, DateTime lastMessageTime);

@injectable
class MessagesViewModel extends Cubit<MessagesStates> {
  final GetOrderMessagesUseCase getMessagesUseCase;
  final SubscribeToMessagesUseCase subscribeToMessagesUseCase;
  final OnConversationUpdated? onConversationUpdated;

  late final MarkMessageAsReadViewModel markVM;

  MessagesViewModel(
      this.getMessagesUseCase,
      this.subscribeToMessagesUseCase, {
        @factoryParam this.onConversationUpdated, // ✅ factory param
      }) : super(MessagesInitial()) {
    markVM = getIt<MarkMessageAsReadViewModel>();
  }



  StreamSubscription<(MessageEntity, String)>? _subscription;
  List<MessageEntity> _messages = [];

  Future<void> loadAndSubscribeMessages(
      String orderId,
      String currentUserId,
      String otherUserId,
      ) async {
    await _subscription?.cancel();

    emit(MessagesLoading());
    print("📥 Fetching old messages...");

    final result = await getMessagesUseCase(orderId, currentUserId, otherUserId);

    result.fold(
          (failure) => emit(MessagesError(failure: failure)),
          (messages) {
        print("✅ Got ${messages.length} old messages");
        _messages = messages;
        emit(MessagesSuccess(messages: List.from(_messages)));
      },
    );

    print("🔔 Subscribing to realtime updates...");
    _subscription = subscribeToMessagesUseCase(orderId, currentUserId, otherUserId).listen(
          (data) {
        final (message, action) = data;

        print("🟢 Realtime event: $action | messageId: ${message.id}");

        if (action == 'INSERT') {
          final exists = _messages.any((m) => m.id == message.id);
          if (!exists) _messages.add(message);
        } else if (action == 'UPDATE') {
          final index = _messages.indexWhere((m) => m.id == message.id);
          if (index != -1) _messages[index] = message;
        } else if (action == 'DELETE') {
          _messages.removeWhere((m) => m.id == message.id);
        }

        if (action == 'INSERT' || action == 'UPDATE') {
          final exists = _messages.any((m) => m.id == message.id);
          if (!exists) _messages.add(message);
          else {
            final index = _messages.indexWhere((m) => m.id == message.id);
            _messages[index] = message;
          }

          onConversationUpdated?.call(orderId, message.createdAt);
        }

        _messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        emit(MessagesSuccess(messages: List.from(_messages)));
      },
      onError: (error) {
        print("❌ Subscription error: $error");
        emit(MessagesError(failure: ServerFailure(error.toString())));
      },
    );
  }

  void unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
