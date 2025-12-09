import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/messages/data/data_sources/remote/send_messages_remote_data_source/send_messages_remote_data_source.dart';
import 'package:taskly/features/messages/data/models/message_model.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/services/notification_service.dart';
import '../../../../../../core/utils/network_utils.dart';

@Injectable(as: SendMessagesRemoteDataSource)
class SendMessagesRemoteDataSourceImpl extends SendMessagesRemoteDataSource {
  final SupabaseService supabaseService;

  SendMessagesRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, MessageEntity>> sendMessage(
      String orderId, MessageEntity message) async {


    debugPrint("📩 [SendMessagesRemoteDataSource] Sending message...");
    debugPrint("🧾 Order ID: $orderId");
    debugPrint("👤 Sender ID: ${message.senderId}");
    debugPrint("📦 Message type: ${message.messageType}");
    debugPrint("💬 Content: ${message.content}");
    debugPrint("📎 Attachments count: ${message.attachment?.length ?? 0}");

    final phoneRegex = RegExp(r'(\+201[0-9]{9}|01[0-9]{9}|[0-9]{8,})');
    final urlRegex =
    RegExp(r'(https?:\/\/|www\.|facebook\.com|wa\.me|whatsapp\.com)');
    final emailRegex =
    RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');

    if (message.content != null && phoneRegex.hasMatch(message.content!)) {
      debugPrint("🚫 Message blocked: contains phone number");
      return Left(ServerFailure("🚫 يمنع إرسال أرقام التليفون داخل الرسائل"));
    }

    if (message.content != null && urlRegex.hasMatch(message.content!)) {
      debugPrint("🚫 Message blocked: contains URL");
      return Left(ServerFailure("🚫 يمنع إرسال الروابط داخل الرسائل"));
    }

    if (message.content != null && emailRegex.hasMatch(message.content!)) {
      debugPrint("🚫 Message blocked: contains email");
      return Left(ServerFailure("🚫 يمنع إرسال الإيميلات داخل الرسائل"));
    }

    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }
      debugPrint("🧠 Checking payment for order...");
      final String generatedId = const Uuid().v4();

      final paymentResponse = await supabase
          .from('payments')
          .select('id')
          .eq('order_id', orderId)
          .maybeSingle();

      final paymentId =
      paymentResponse != null ? paymentResponse['id'] as String : null;
      debugPrint("💰 Payment ID found: $paymentId");

      final attachmentJson = message.attachment != null
          ? jsonEncode(message.attachment!.map((e) => e.toJson()).toList())
          : null;

      debugPrint("🧱 Preparing insert data...");
      final insertData = {
        'id': generatedId,
        'order_id': orderId,
        'sender_id': message.senderId,
        'receiver_id': message.receiverId,
        'payment_id': paymentId,
        'message_type': message.messageType,
        'content': message.content,
        'attachment': attachmentJson,
        'status': message.status,

      };

      debugPrint("🚀 Inserting message into Supabase...");
      final response =
      await supabase.from('messages').insert(insertData).select().single();

      debugPrint("✅ Message inserted successfully: ${response['id']}");

      final messageModel = MessageModel.fromJson(response);

// 👇 تحقق من حالة المستخدم قبل إرسال الإشعار
      try {
        final userResponse = await supabaseService.supabaseClient
            .from('users')
            .select('is_online')
            .eq('id', message.receiverId)
            .maybeSingle();

        final isOnline = userResponse != null ? userResponse['is_online'] as bool : false;

        if (!isOnline) {
          await NotificationService().sendNotification(
            receiverId: message.receiverId!,
            title: "رسالة جديدة",
            body: message.content ?? "لديك رسالة جديدة",
          );
        } else {
          debugPrint("📱 المستخدم online، لن يتم إرسال إشعار push.");
        }
      } catch (e) {
        debugPrint("❌ خطأ أثناء إرسال الإشعار: $e");
      }

      return Right(messageModel);





      return Right(messageModel);

    } on PostgrestException catch (e) {
      debugPrint("❌ PostgrestException: ${e.message}");
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      debugPrint("💥 Unknown Error: $e");
      debugPrint("🧩 StackTrace: $stack");
      return Left(ServerFailure(e.toString()));
    }
  }
}
