import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/use_cases/get_conversations_use_case/get_conversations_use_case.dart';
import 'get_conversations_states.dart';

@injectable
class GetConversationsViewModel extends Cubit<GetConversationsStates> {
  GetConversationsViewModel(this.getConversationsUseCase)
      : super(GetConversationsInitialStates());

  final GetConversationsUseCase getConversationsUseCase;

  Stream<List<ConversationEntity>>? _conversationsStream;
  StreamSubscription<List<ConversationEntity>>? _conversationsSubscription;

  Future<void> getConversations(String userId) async {
    try {
      emit(GetConversationsLoadingStates());

      // 1️⃣ fetch الحالي
      final fetchResult = await getConversationsUseCase.call(userId);
      List<ConversationEntity> currentConversations = [];
      fetchResult.fold(
            (l) => emit(GetConversationsErrorStates(errorMessage: "Error, try again")),
            (r) {
          currentConversations = r;
          emit(GetConversationsSuccessStates(conversationsList: r));
        },
      );

      _conversationsSubscription?.cancel();
      _conversationsStream = getConversationsUseCase.subscribeToConversations(userId);

      _conversationsSubscription = _conversationsStream!.listen((updatedConversations) {
        final merged = [
          ...currentConversations.where(
                (c) => !updatedConversations.any((u) => u.user.id == c.user.id),
          ),
          ...updatedConversations
        ];

        currentConversations = merged;

        // ✅ رتب المحادثات حسب آخر رسالة
        currentConversations.sort((a, b) {
          final aTime = a.lastMessageTime ?? DateTime.fromMillisecondsSinceEpoch(0);
          final bTime = b.lastMessageTime ?? DateTime.fromMillisecondsSinceEpoch(0);
          return bTime.compareTo(aTime); // الأحدث في الأول
        });

        emit(GetConversationsSuccessStates(conversationsList: currentConversations));
      });

    } catch (e) {
      emit(GetConversationsErrorStates(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _conversationsSubscription?.cancel();
    return super.close();
  }
}
