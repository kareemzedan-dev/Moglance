import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackVideo extends StatelessWidget {
  final VideoPlayerController controller;

  const BackVideo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: controller.value.isInitialized
          ? FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            )
          : Container(color: const Color(0xFF6D1AD3))
      ,
    );
  }
}
