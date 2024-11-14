import 'dart:async';
import 'dart:io';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecorderManager {
  static final RecorderManager _instance = RecorderManager._internal();

  factory RecorderManager() {
    return _instance;
  }

  RecorderManager._internal() {
    // يمكنك وضع أي تهيئة هنا إذا لزم الأمر
  }

  AnotherAudioRecorder? _recorder;
  String? _filePath;
  bool _isRecording = false;
  bool _isPaly = false;
  AudioPlayer _audioPlayer=AudioPlayer();
  StreamSubscription<Duration>? positionSubscription;

  Future<void> init({required String path}) async {
    // طلب الصلاحيات
    await Permission.microphone.request();
    await Permission.storage.request();

    if (await Permission.microphone.isGranted) {
      // تهيئة المسار للتسجيل
      String? currentPath = await _getFilePath();
      _recorder =
          AnotherAudioRecorder(currentPath, audioFormat: AudioFormat.AAC);
      await _recorder!.initialized;
      print("Recorder initialized with path: $path");
    } else {
      throw Exception('الرجاء منح الصلاحيات للوصول إلى الميكروفون والتخزين.');
    }
  }

  Future<String> _getFilePath() async {
    Directory? directory;
    try {
      directory = await getApplicationDocumentsDirectory();
    } catch (e) {
      print("Could not get the directory: $e");
    }

    if (directory != null) {
      return '${directory.path}/record_${DateTime.now().millisecondsSinceEpoch}.aac';
    } else {
      throw Exception('لم يتم العثور على مسار التخزين.');
    }
  }

  Future<void> startRecording() async {
    if (_recorder != null) {
      await _recorder!.start();

      _isRecording = true;
      print("Recording started");
    } else {
      print("Recorder is not initialized");
    }
  }

  Future<String?> stopRecording() async {
    if (_recorder != null && _isRecording) {
      try {
        Recording? recording = await _recorder!.stop();
        _isRecording = false;
        print("STOP RECORD ${recording?.path}");
        return recording?.path;
      } catch (e) {
        print("Error stopping recording: $e");
        return null;
      }
    } else {
      print("Recorder is not initialized or not recording.");
      return null;
    }
  }



  Future<void> playRecordedAudioNetWork({
    String? path,
    String? filePath,
    String? assets,
    Function(int position, Duration? duration)? onChangeSeek,
    Function(bool end)? onEnd,

  }) async {
    MainController mainController = Get.find<MainController>();
    if (mainController.isPlayAudio.value == true) {
      _audioPlayer.stop();
      mainController.isPlayAudio.value = false;
    }

    if (path != null) {
      mainController.isPlayAudio.value = true;
      await _audioPlayer.play(UrlSource(path));
    }
    //
    else if (filePath != null) {
      mainController.isPlayAudio.value == true;
      await _audioPlayer.play(DeviceFileSource(filePath));
    }
    else if(assets !=null){
      mainController.isPlayAudio.value = true;
      await _audioPlayer.play(AssetSource(assets));
    }
    if (path != null || filePath != null) {
      Duration? duration = await _audioPlayer.getDuration();
      if (onChangeSeek != null) {
        positionSubscription = _audioPlayer.onPositionChanged.listen(
              (Duration position) {
            // عند الوصول إلى نهاية الصوت، استدعي onEnd
            if (onEnd != null && duration != null) {
              if (duration.inSeconds == position.inSeconds) {
                onEnd(false); // الصوت انتهى
              } else {
                mainController.isPlayAudio.value = false;
                onEnd(true); // الصوت لا يزال قيد التشغيل
              }
            }
            // تحديث موضع الصوت
            onChangeSeek(position.inMilliseconds, duration);
          },
        );
      }
    }
  }
  Future<void> StopPlayRecordedAudio() async {
    await _audioPlayer!.stop();
    print("Audio playback stopped");
  }

  Future<void> dispose() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.dispose();
      print("AudioPlayer disposed");
    }
  }
}
