import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/presentation/manager/subscribe_to_unread_messages_view_model/subscribe_to_unread_messages_view_model_states.dart';
import '../../../domain/use_cases/subscribe_to_unread_messages_use_case/subscribe_to_unread_messages_use_case.dart';
import '../../../domain/entities/message_entity.dart';

@injectable
class SubscribeToUnreadMessagesViewModel
    extends Cubit<SubscribeToUnreadMessagesViewModelStates> {
  final SubscribeToUnreadMessagesUseCase useCase;

  StreamSubscription<List<MessageEntity>>? _subscription;

  SubscribeToUnreadMessagesViewModel(this.useCase)
      : super(SubscribeToUnreadMessagesViewModelStatesInitial());

  /// ✅ يبدأ الاشتراك في Stream الرسائل الغير مقروءة
  Future<void> getUnreadMessagesStream(String currentUserId) async {
    emit(SubscribeToUnreadMessagesViewModelStatesLoading());

    // إلغاء أي اشتراك سابق
    await _subscription?.cancel();

    try {
      final stream = useCase(currentUserId);

      _subscription = stream.listen(
            (messages) {
          emit(SubscribeToUnreadMessagesViewModelStatesSuccess(messages));
        },
        onError: (error) {
          emit(SubscribeToUnreadMessagesViewModelStatesError(error));
        },
      );
    } catch (e) {
      emit(SubscribeToUnreadMessagesViewModelStatesError(e.toString()));
    }
  }

  /// ✅ إلغاء الاشتراك
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() async {
    await stop();
    return super.close();
  }
}
