import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendRecordButton extends StatelessWidget {
  final bool isTyping;
  final bool isSending;
  final bool isRecording;
  final VoidCallback onSendText;
  final VoidCallback onStartStopRecord;

  const SendRecordButton({
    super.key,
    required this.isTyping,
    required this.isSending,
    required this.isRecording,
    required this.onSendText,
    required this.onStartStopRecord,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        gradient: isTyping && !isSending
            ? const LinearGradient(
          colors: [Color(0xFF25D366), Color(0xFF128C7E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        color: !isTyping
            ? (isRecording ? Colors.redAccent : Colors.grey.shade300)
            : (isSending ? Colors.grey.shade400 : null),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22.r),
        onTap: isTyping && !isSending ? onSendText : onStartStopRecord,
        child: Center(
          child: isSending
              ? SizedBox(
            width: 18.w,
            height: 18.h,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Icon(
            isTyping
                ? CupertinoIcons.paperplane_fill
                : (isRecording
                ? CupertinoIcons.stop_fill
                : CupertinoIcons.mic_fill),
            color: isTyping
                ? Colors.white
                : (isRecording
                ? Colors.white
                : Colors.grey.shade600),
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}