import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/features/messages/presentation/manager/send_message_view_model/send_message_view_model.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/messages/presentation/widgets/chat_input_field.dart';

class ChatInputSection extends StatelessWidget {
  final String orderId;
  final String currentUserId;
  final String receiverId;
  final String currentUserRole;
  final String receiverUserRole;
  final VoidCallback? onMessageSent;

  const ChatInputSection({
    super.key,
    required this.orderId,
    required this.currentUserId,
    required this.receiverId,
    required this.currentUserRole,
    required this.receiverUserRole,
    this.onMessageSent,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SendMessageViewModel>()),
        BlocProvider(create: (_) => getIt<UploadAttachmentsViewModel>()),
      ],
      child: ChatInputField(
        orderId: orderId,
        currentUserId: currentUserId,
        receiverId: receiverId,
        currentUserRole: currentUserRole,
        receiverUserRole: receiverUserRole,
        onMessageSent: onMessageSent,
      ),
    );
  }
}