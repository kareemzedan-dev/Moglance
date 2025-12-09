// widgets/voice_message_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

class VoiceMessageWidget extends StatefulWidget {
  final String fileUrl;
  final String time;
  final bool isCurrentUser;
  final String avatarUrl;
  final String userName;

  const VoiceMessageWidget({
    super.key,
    required this.fileUrl,
    required this.time,
    required this.isCurrentUser,
    required this.avatarUrl,
    required this.userName,
  });

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  late final AudioPlayer _player;
  bool isPlaying = false;
  Duration? duration;
  Duration? position;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _player.durationStream.listen((d) {
      if (mounted) setState(() => duration = d);
    });

    _player.positionStream.listen((p) {
      if (mounted) setState(() => position = p);
    });

    _player.playerStateStream.listen((state) {
      if (mounted) {
        if (state.playing) {
          setState(() => isPlaying = true);
        } else {
          setState(() => isPlaying = false);
        }
        if (state.processingState == ProcessingState.completed) {
          _player.seek(Duration.zero);
        }
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      try {
        await _player.setUrl(widget.fileUrl);
        await _player.play();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في تشغيل الرسالة الصوتية')),
        );
      }
    }
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = position ?? Duration.zero;
    final totalDuration = duration ?? Duration.zero;
    final progress = totalDuration.inSeconds > 0
        ? currentPosition.inSeconds / totalDuration.inSeconds
        : 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: widget.isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!widget.isCurrentUser) ...[
            UserAvatar(imagePath: widget.avatarUrl,
                userName: widget.userName,
                radius: 16.r),
            SizedBox(width: 8.w),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 0.65.sw),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: widget.isCurrentUser ? ColorsManager.primary : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(widget.isCurrentUser ? 16.r : 0),
                  bottomRight: Radius.circular(widget.isCurrentUser ? 0 : 16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: widget.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // زر التشغيل
                      GestureDetector(
                        onTap: _togglePlay,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: widget.isCurrentUser ? Colors.white.withOpacity(0.2) : ColorsManager.primary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: widget.isCurrentUser ? Colors.white : ColorsManager.primary,
                            size: 20.r,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // شريط التقدم
                      Expanded(
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 2.h,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 6.r,
                                ),
                                overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 10.r,
                                ),
                                activeTrackColor: widget.isCurrentUser
                                    ? Colors.white
                                    : ColorsManager.primary,
                                inactiveTrackColor: widget.isCurrentUser
                                    ? Colors.white.withOpacity(0.3)
                                    : ColorsManager.primary.withOpacity(0.3),
                                thumbColor: widget.isCurrentUser
                                    ? Colors.white
                                    : ColorsManager.primary,
                              ),
                              child: Slider(
                                value: progress.clamp(0.0, 1.0),
                                onChanged: (value) {
                                  if (duration != null) {
                                    final newPosition = duration! * value;
                                    _player.seek(newPosition);
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(position),
                                  style: TextStyle(
                                    color: widget.isCurrentUser
                                        ? Colors.white.withOpacity(0.8)
                                        : ColorsManager.black.withOpacity(0.6),
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  _formatDuration(duration),
                                  style: TextStyle(
                                    color: widget.isCurrentUser
                                        ? Colors.white.withOpacity(0.8)
                                        : ColorsManager.black.withOpacity(0.6),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.isCurrentUser
                          ? Colors.white.withOpacity(0.8)
                          : ColorsManager.black.withOpacity(0.6),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.isCurrentUser) ...[
            SizedBox(width: 8.w),
            UserAvatar(imagePath: widget.avatarUrl,
                userName:  widget.userName,
                radius: 16.r),
          ],
        ],
      ),
    );
  }
}