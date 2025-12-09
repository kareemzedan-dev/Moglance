import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceRecordButton extends StatelessWidget {
  final bool isRecording;
  final bool isSending;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;

  const VoiceRecordButton({
    super.key,
    required this.isRecording,
    required this.isSending,
    required this.onStartRecording,
    required this.onStopRecording,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isRecording ? 120.w : 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: isRecording ? Color(0xFF1F2C34) : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: isRecording
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mic_rounded,
            size: 20.sp,
            color: Colors.red,
          ),
          SizedBox(width: 6.w),
          Text(
            'Recording...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onStopRecording,
            child: Icon(
              Icons.send_rounded,
              size: 16.sp,
              color: Color(0xFF008069),
            ),
          ),
        ],
      )
          : IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.mic_rounded,
          size: 22.sp,
          color: Color(0xFF54656F),
        ),
        onPressed: isSending ? null : onStartRecording,
      ),
    );
  }
}