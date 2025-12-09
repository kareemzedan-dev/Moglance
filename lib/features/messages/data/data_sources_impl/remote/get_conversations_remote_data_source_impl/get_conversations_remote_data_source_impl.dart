import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/shared/data/models/order_dm/order_dm.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/utils/network_utils.dart';
import '../../../../../profile/domain/entities/user_info_entity/user_info_entity.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../../domain/entities/conversation_entity.dart';
import '../../../data_sources/remote/get_conversations_remote_data_source/get_conversations_remote_data_source.dart';
@Injectable(as: GetConversationsRemoteDataSource)
class GetUserConversationsRemoteDataSourceImpl
    implements GetConversationsRemoteDataSource {
  final SupabaseService supabaseService;

  GetUserConversationsRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<ConversationEntity>>> getConversations(
      String userId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }
      final response = await supabaseService.supabaseClient
          .from('messages')
          .select('sender_id, receiver_id, created_at, content, order_id')
          .or('sender_id.eq.$userId,receiver_id.eq.$userId');

      final Map<String, Map<String, dynamic>> latestConversations = {};

      for (final msg in response) {
        final sender = msg['sender_id']?.toString();
        final receiver = msg['receiver_id']?.toString();
        if (sender == null || receiver == null) continue;

        final otherUserId = sender == userId ? receiver : sender;

        final existingMsg = latestConversations[otherUserId];
        if (existingMsg == null ||
            DateTime.parse(msg['created_at'])
                .isAfter(DateTime.parse(existingMsg['created_at']))) {
          latestConversations[otherUserId] = Map<String, dynamic>.from(msg);
        }
      }

      final userIds = latestConversations.keys.toList();
      if (userIds.isEmpty) return const Right([]);

      final usersResponse = await supabaseService.supabaseClient
          .from('users')
          .select()
          .inFilter('id', userIds);

      final orderIds = latestConversations.values
          .map((msg) => msg['order_id'])
          .where((id) => id != null)
          .toList();

      Map<String, OrderEntity> ordersMap = {};
      if (orderIds.isNotEmpty) {
        final ordersResponse = await supabaseService.supabaseClient
            .from('orders')
            .select()
            .inFilter('id', orderIds);

        ordersMap = {
          for (final o in ordersResponse)
            o['id']: OrderDm.fromJson(Map<String, dynamic>.from(o as Map))
                .toEntity()
        };
      }

      final List<ConversationEntity> conversations = (usersResponse as List)
          .map((u) {
        final user = Map<String, dynamic>.from(u as Map);
        final lastMsgData = latestConversations[user['id']];
        final orderId = lastMsgData?['order_id']?.toString();

        return ConversationEntity(
          user: UserInfoEntity(
            id: user['id'],
            fullName: user['full_name'] ?? '',
            email: user['email'] ?? '',
            profileImage: user['profile_image'],
            role: user['role'] ?? '',
          ),
          lastMessage: lastMsgData?['content'],
          lastMessageTime: lastMsgData?['created_at'] != null
              ? DateTime.tryParse(lastMsgData!['created_at'])
              : null,
          orderId: orderId,
          order: orderId != null ? ordersMap[orderId] : null,
        );
      }).toList();

      conversations.sort((a, b) =>
          (b.lastMessageTime ?? DateTime(0))
              .compareTo(a.lastMessageTime ?? DateTime(0)));

      return Right(conversations);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // 🔹 الإصلاح: ترتيب الرسائل بعد الوصول لها + emit list جديدة
  Stream<List<ConversationEntity>> subscribeToConversations(String userId) {
    final stream = supabaseService.supabaseClient
        .from('messages')
        .stream(primaryKey: ['id'])
        .map((messages) => (messages as List)
        .where((m) => m['sender_id'] == userId || m['receiver_id'] == userId)
        .toList());

    return stream.asyncMap((messages) async {
      final Map<String, Map<String, dynamic>> latestConversations = {};

      for (final msg in messages) {
        final sender = msg['sender_id']?.toString();
        final receiver = msg['receiver_id']?.toString();
        if (sender == null || receiver == null) continue;

        final otherUserId = sender == userId ? receiver : sender;

        final existingMsg = latestConversations[otherUserId];
        if (existingMsg == null ||
            DateTime.parse(msg['created_at'])
                .isAfter(DateTime.parse(existingMsg['created_at']))) {
          latestConversations[otherUserId] = Map<String, dynamic>.from(msg);
        }
      }

      final userIds = latestConversations.keys.toList();
      if (userIds.isEmpty) return <ConversationEntity>[];

      final usersResponse = await supabaseService.supabaseClient
          .from('users')
          .select()
          .inFilter('id', userIds);

      final orderIds = latestConversations.values
          .map((msg) => msg['order_id'])
          .where((id) => id != null)
          .toList();

      Map<String, OrderEntity> ordersMap = {};
      if (orderIds.isNotEmpty) {
        final ordersResponse = await supabaseService.supabaseClient
            .from('orders')
            .select()
            .inFilter('id', orderIds);

        ordersMap = {
          for (final o in ordersResponse)
            o['id']: OrderDm.fromJson(Map<String, dynamic>.from(o as Map))
                .toEntity()
        };
      }

      final List<ConversationEntity> conversations = (usersResponse as List)
          .map((u) {
        final user = Map<String, dynamic>.from(u as Map);
        final lastMsgData = latestConversations[user['id']];
        final orderId = lastMsgData?['order_id']?.toString();

        return ConversationEntity(
          user: UserInfoEntity(
            id: user['id'],
            fullName: user['full_name'] ?? '',
            email: user['email'] ?? '',
            profileImage: user['profile_image'],
            role: user['role'] ?? '',
          ),
          lastMessage: lastMsgData?['content'],
          lastMessageTime: lastMsgData?['created_at'] != null
              ? DateTime.tryParse(lastMsgData!['created_at'])
              : null,
          orderId: orderId,
          order: orderId != null ? ordersMap[orderId] : null,
        );
      }).toList();

      conversations.sort((a, b) =>
          (b.lastMessageTime ?? DateTime(0))
              .compareTo(a.lastMessageTime ?? DateTime(0)));

      return List<ConversationEntity>.from(conversations); // emit نسخة جديدة
    });
  }
}

