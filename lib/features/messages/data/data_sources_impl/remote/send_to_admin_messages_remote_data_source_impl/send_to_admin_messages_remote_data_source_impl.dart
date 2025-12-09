import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import '../../../../../../core/utils/network_utils.dart';
import '../../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../data_sources/remote/send_to_admin_messages_remote_data_source/send_to_admin_messages_remote_data_source.dart';
import '../../../models/message_model.dart';
@Injectable(as:  SendToAdminMessagesRemoteDataSource)
class SendToAdminMessagesRemoteDataSourceImpl
    implements SendToAdminMessagesRemoteDataSource {

  final SupabaseClient supabase;

  SendToAdminMessagesRemoteDataSourceImpl(this.supabase);
  @override
  Future<Either<Failures, void>> SendToAdminMessage({required MessageEntity message}) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }
      String adminId = message.receiverId.isNotEmpty ? message.receiverId : '';

      if (adminId.isEmpty) {
        final response = await supabase.from('admins').select('id').limit(1);
        final data = response as List;
        if (data.isEmpty) {
          return Left(ServerFailure("No admin found"));
        }
        adminId = data.first['id'] as String;
      }

      final attachments = message.attachment?.map((a) {
        return AttachmentModel(
          id: a.id,
          url: a.url,
          type: a.type,
          name: a.name,
          size: a.size,
          storagePath: a.storagePath,
        );
      }).toList();


      final adminMessage = MessageModel(
        id: message.id,
        senderId: message.senderId,
        receiverId: adminId,
        messageType: message.messageType,
        content: message.content,
        attachment: attachments,
        status: message.status,
        createdAt: message.createdAt,
        updatedAt: message.updatedAt,
        senderType: message.senderType,
        receiverType: message.receiverType,
        orderId: message.orderId,
        paymentId: message.paymentId,
      );

      print("🟢 Sending admin message: ${adminMessage.toJson()}");

      await supabase.from('messages').insert([adminMessage.toJson()]);

      return const Right(null);
    } catch (e) {
      print("❌ Send message failed: $e");
      return Left(ServerFailure(e.toString()));
    }
  }


}
