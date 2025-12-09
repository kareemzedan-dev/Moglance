import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class VoiceRecordingService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _recordingPath;

  Future<bool> checkPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<String?> startRecording() async {
    try {
      final hasPermission = await checkPermission();
      if (!hasPermission) return null;

      final dir = await getTemporaryDirectory();
      _recordingPath = '${dir.path}/${const Uuid().v4()}.m4a';

      await _audioRecorder.start(
        const RecordConfig(),
        path: _recordingPath!,
      );

      return _recordingPath;
    } catch (e) {
      print('Error starting recording: $e');
      return null;
    }
  }

  Future<String?> stopRecording() async {
    try {
      await _audioRecorder.stop();
      final path = _recordingPath;
      _recordingPath = null;

      if (path != null && File(path).existsSync()) {
        return path;
      }
      return null;
    } catch (e) {
      print('Error stopping recording: $e');
      return null;
    }
  }

  void dispose() {
    _audioRecorder.dispose();
  }
}