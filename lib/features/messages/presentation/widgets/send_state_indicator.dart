import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/send_message_view_model/send_message_view_model.dart';
import '../manager/send_message_view_model/send_message_view_model_states.dart';

class SendStateIndicator extends StatelessWidget {
  final bool isSendingVoice;

  const SendStateIndicator({
    super.key,
    required this.isSendingVoice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageViewModel, SendMessageViewModelStates>(
      builder: (context, state) {
        final isLoading = state is SendMessageViewModelStatesLoading;

        if (isLoading || isSendingVoice) {
          return SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: Colors.blue,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}