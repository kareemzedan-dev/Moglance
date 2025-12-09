import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/utils/videos_manager.dart';
import 'package:video_player/video_player.dart';
import 'welcome_states.dart';

class WelcomeViewModel extends Cubit<WelcomeState> {
  late VideoPlayerController _controller;

  VideoPlayerController get controller => _controller;

  WelcomeViewModel() : super(  WelcomeState()) {
    _initVideo();
  }
  Future<void> _initVideo() async {
    emit(state.copyWith(status: WelcomeStatus.loading));

    try {
      _controller = VideoPlayerController.asset(VideosManager.welcomeVideo);

      await _controller.initialize();

      _controller
        ..setLooping(true)
        ..setVolume(0.0)
        ..play();

      emit(state.copyWith(status: WelcomeStatus.videoReady));

    } catch (e) {
      print("❌ Video load error: $e");
      emit(state.copyWith(status: WelcomeStatus.error));
    }
  }

void selectRole(UserRole role) {
  emit(state.copyWith(selectedRole: role));
}


  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
