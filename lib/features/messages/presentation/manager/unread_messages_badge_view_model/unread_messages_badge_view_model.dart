import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/presentation/manager/unread_messages_badge_view_model/unread_badge_states.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/use_cases/subscribe_to_messages_use_case/subscribe_to_messages_use_case.dart';
import '../../../domain/use_cases/get_order_messages_use_case/get_order_messages_use_case.dart';
import '../../../../../../../../../core/errors/failures.dart';

@injectable
class UnreadMessagesBadgeViewModel extends Cubit<UnreadMessagesBadgeState> {
  final GetOrderMessagesUseCase getMessagesUseCase;
  final SubscribeToMessagesUseCase subscribeToMessagesUseCase;

  final Map<String, int> _unreadCounts = {}; // 👈 لكل orderId
  final Map<String, StreamSubscription<(MessageEntity, String)>> _subscriptions = {};

  StreamSubscription<List<MessageEntity>>? _globalSubscription; // ✅ اشتراك عام
  int _globalUnreadCount = 0;

  UnreadMessagesBadgeViewModel(
      this.getMessagesUseCase,
      this.subscribeToMessagesUseCase,
      ) : super(UnreadMessagesBadgeInitial());

  // ✅ الاشتراك الخاص بكل orderId
  Future<void> start(String orderId, String currentUserId, String otherUserId) async {
    // إلغاء أي اشتراك سابق لنفس الـ orderId
    await _subscriptions[orderId]?.cancel();

    final result = await getMessagesUseCase(orderId, currentUserId, otherUserId);

    result.fold(
          (failure) => emit(UnreadMessagesBadgeError(failure)),
          (messages) {
        _unreadCounts[orderId] = messages
            .where((msg) => msg.receiverId == currentUserId && msg.seenAt == null)
            .length;

        emit(UnreadMessagesBadgeUpdated(Map.from(_unreadCounts)));
      },
    );

    final sub = subscribeToMessagesUseCase(orderId, currentUserId, otherUserId).listen((data) {
      final (message, action) = data;

      if (action == 'INSERT' && message.receiverId == currentUserId && message.seenAt == null) {
        _unreadCounts[orderId] = (_unreadCounts[orderId] ?? 0) + 1;
      } else if (action == 'UPDATE' && message.receiverId == currentUserId && message.seenAt != null) {
        final currentCount = _unreadCounts[orderId] ?? 0;
        _unreadCounts[orderId] = currentCount > 0 ? currentCount - 1 : 0;
      }

      emit(UnreadMessagesBadgeUpdated(Map.from(_unreadCounts)));
    });

    _subscriptions[orderId] = sub;
  }

  // ✅ متابعة عامة لكل الرسائل من جميع الطلبات
  Future<void> startGlobal(
      String currentUserId,
      Stream<List<MessageEntity>> Function(String) getAllMessagesStream,
      ) async {
    await _globalSubscription?.cancel();

    _globalSubscription = getAllMessagesStream(currentUserId).listen((messages) {
      _globalUnreadCount = messages
          .where((m) => m.receiverId == currentUserId && m.seenAt == null)
          .length;

      emit(UnreadMessagesBadgeUpdated({'global': _globalUnreadCount}));
    });
  }

  // ✅ Getter للمحادثات الخاصة
  int getUnreadCount(String orderId) => _unreadCounts[orderId] ?? 0;

  // ✅ Getter للإجمالي العام
  int getGlobalUnreadCount() => _globalUnreadCount;

  // ✅ عند فتح محادثة معينة
  void markAsRead(String orderId) {
    if (_unreadCounts.containsKey(orderId)) {
      _unreadCounts[orderId] = 0;
      emit(UnreadMessagesBadgeUpdated(Map.from(_unreadCounts)));
    }
  }
    String adminConversationKey = 'admin';

  void markAdminAsRead() {
    _unreadCounts[adminConversationKey] = 0;
    emit(UnreadMessagesBadgeUpdated(Map.from(_unreadCounts)));
  }

  @override
  Future<void> close() async {
    for (final sub in _subscriptions.values) {
      await sub.cancel();
    }
    await _globalSubscription?.cancel();
    return super.close();
  }


}
