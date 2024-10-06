import 'dart:io';

import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
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
  AudioPlayer? _audioPlayer;

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

  Future<void> playRecordedAudio({String? path}) async {
    _audioPlayer = AudioPlayer();
    if (path != null) {
      await _audioPlayer!.play(
        DeviceFileSource(path),
      );
      print("Playing audio from path: $path");
    } else if (_filePath != null) {
      await _audioPlayer!.play(DeviceFileSource(_filePath!));
      print("Playing audio from path: $_filePath");
    } else {
      print("No audio file path provided");
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
