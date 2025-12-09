import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import '../../../domain/use_cases/subscribe_to_admin_messages_use_case/subscribe_to_admin_messages_use_case.dart';
import 'subscribe_to_admin_messages_states.dart';

@injectable
class SubscribeToAdminMessagesViewModel extends Cubit<SubscribeToAdminMessagesStates> {
  final SubscribeToAdminMessagesUseCase subscribeToAdminMessagesUseCase;
  List<MessageEntity> messages = [];

  SubscribeToAdminMessagesViewModel(this.subscribeToAdminMessagesUseCase)
      : super(SubscribeToAdminMessagesInitial());
  RealtimeChannel? _channel;

  void subscribeToAdminMessages(String currentUserId,
      void Function(MessageEntity message, String action)? onChange) async {
    emit(SubscribeToAdminMessagesLoadingState());

    try {
      _channel = await subscribeToAdminMessagesUseCase.subscribeToAdminMessages(
        currentUserId,
            (message, action) {
          if (!messages.any((m) => m.id == message.id)) {
            messages.add(message);
            emit(SubscribeToAdminMessagesSuccessState(List.from(messages)));
          }
          onChange?.call(message, action);
        },
      );
    } catch (e) {
      emit(SubscribeToAdminMessagesErrorState(ServerFailure("We are sorry, try again")));
    }
  }

  void unsubscribe() {
    _channel?.unsubscribe();
    _channel = null;
    messages.clear();
    emit(SubscribeToAdminMessagesInitial());
  }

}
