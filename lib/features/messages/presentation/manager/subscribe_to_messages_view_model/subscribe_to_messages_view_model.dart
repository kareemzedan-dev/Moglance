import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:taskly/features/messages/domain/use_cases/subscribe_to_messages_use_case/subscribe_to_messages_use_case.dart';
import 'subscribe_to_messages_states.dart';

@injectable
class SubscribeToMessagesViewModel extends Cubit<SubscribeToMessagesStates> {
  final SubscribeToMessagesUseCase subscribeToMessagesUseCase;

  SubscribeToMessagesViewModel(this.subscribeToMessagesUseCase)
      : super(SubscribeToMessagesStatesInitial());

  StreamSubscription<(MessageEntity, String)>? _subscription;

  Future<void> subscribeToMessages(String orderId, String currentUserId, String otherUserId) async {
    try {
      emit(SubscribeToMessagesStatesLoading());

      // Start listening to the stream
      _subscription = subscribeToMessagesUseCase.call(orderId, currentUserId, otherUserId ).listen(
            (event) {
          final (message, action) = event;

          final currentMessages = state is SubscribeToMessagesStatesSuccess
              ? List<MessageEntity>.from(
              (state as SubscribeToMessagesStatesSuccess).messages)
              : <MessageEntity>[];

          if (action == 'INSERT') {
            currentMessages.add(message);
          } else if (action == 'UPDATE') {
            final index = currentMessages.indexWhere((m) => m.id == message.id);
            if (index != -1) currentMessages[index] = message;
          } else if (action == 'DELETE') {
            currentMessages.removeWhere((m) => m.id == message.id);
          }

          // ترتيب حسب الوقت
          currentMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

          emit(SubscribeToMessagesStatesSuccess(messages: currentMessages));
        },
        onError: (error) {
          emit(SubscribeToMessagesStatesError(
              failure: ServerFailure(error.toString())));
        },
      );
    } catch (e) {
      emit(SubscribeToMessagesStatesError(
          failure: ServerFailure(e.toString())));
    }
  }

  void unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() {
    unsubscribe();
    return super.close();
  }
}
