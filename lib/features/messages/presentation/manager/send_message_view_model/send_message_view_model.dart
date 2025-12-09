import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/use_cases/send_message_use_case/send_message_use_case.dart';
import 'send_message_view_model_states.dart';
import '../../../../../../../../../core/errors/failures.dart';

@injectable
class SendMessageViewModel extends Cubit<SendMessageViewModelStates> {
  final SendMessageUseCase sendMessageUseCase;

  SendMessageViewModel(this.sendMessageUseCase)
      : super(SendMessageViewModelStatesInitial());

  final List<MessageEntity> _temporaryMessages = [];
  bool _isSending = false;

  List<MessageEntity> get temporaryMessages => _temporaryMessages;

  void addTemporaryMessage(MessageEntity message) {
    if (_isSending) return;
    _temporaryMessages.add(message);
    emit(SendMessageViewModelStatesTemporary(messages: List.from(_temporaryMessages)));
  }

  void updateMessage(MessageEntity updatedMessage) {
    final index = _temporaryMessages.indexWhere((m) => m.id == updatedMessage.id);
    if (index != -1) {
      _temporaryMessages[index] = updatedMessage;
      emit(SendMessageViewModelStatesTemporary(messages: List.from(_temporaryMessages)));
    }
  }

  void removeTemporaryMessage(String messageId) {
    _temporaryMessages.removeWhere((m) => m.id == messageId);
    emit(SendMessageViewModelStatesTemporary(messages: List.from(_temporaryMessages)));
  }

  Future<void> sendMessage(MessageEntity message, {String? orderId}) async {
    if (_isSending) return;

    _isSending = true;
    try {
      if (!_temporaryMessages.any((m) => m.id == message.id)) {
        addTemporaryMessage(message);
      }

      emit(SendMessageViewModelStatesLoading());

      final result = await sendMessageUseCase.call(orderId!, message);
      result.fold(
            (failure) {
          removeTemporaryMessage(message.id!);
          emit(SendMessageViewModelStatesError(failure: failure.message));
        },
            (sentMessage) {
          updateMessage(sentMessage.copyWith(status: "sent"));
          emit(SendMessageViewModelStatesSuccess(message: sentMessage));
        },
      );

    } catch (e) {
      removeTemporaryMessage(message.id!);
      emit(SendMessageViewModelStatesError(
        failure: "حدث خطأ غير متوقع أثناء إرسال الرسالة.",
      ));
    } finally {
      _isSending = false;
    }
  }

  String _mapFailureToArabic(Failures failure) {
    final msg = failure.message ?? '';

    if (msg.contains("phone") || msg.contains("رقم")) {
      return "🚫 يمنع إرسال أرقام الهواتف داخل الرسائل.";
    } else if (msg.contains("network") || msg.contains("socket")) {
      return "📡 تأكد من اتصالك بالإنترنت.";
    } else if (msg.contains("timeout")) {
      return "⏱ انتهت مهلة الاتصال بالخادم.";
    } else if (msg.contains("permission")) {
      return "🚷 لا تملك صلاحية لإرسال هذه الرسالة.";
    } else if (msg.contains("يمنع")) {
      // ✅ نضيف شرط عام لأي رسالة تبدأ بـ 🚫 يمنع
      return msg;
    } else if (msg.isEmpty) {
      return "حدث خطأ أثناء إرسال الرسالة.";
    } else {
      return msg;
    }
  }


  void clearTemporaryMessages() {
    _temporaryMessages.clear();
    emit(SendMessageViewModelStatesInitial());
  }
}
