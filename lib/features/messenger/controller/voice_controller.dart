import 'package:file/src/interface/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/file/size.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/app.dart';
import '../../../core/app/config/app_setting.dart';
import 'package:audio_session/audio_session.dart';

enum AudioState { loading, prepare, ready, error }

enum PlayState { play, pause }

class VoiceController {
  RxString size = ''.obs;
  final String voiceUrl;
  final DefaultCacheManager defaultCacheManager = DefaultCacheManager();
  final Rx<AudioState> audioState = AudioState.loading.obs;
  final Rx<PlayState> playState = PlayState.pause.obs;
  final AudioPlayer audioPlayer = AudioPlayer();

  VoiceController({required this.voiceUrl});

  Stream<FileResponse> get fileStream => defaultCacheManager.getFileStream(
        '${AppSetting.baseUrl}/doctor/file/$voiceUrl',
        withProgress: true,
      );

  onVoiceTap() async {
    if (playState.value == PlayState.play) {
      pause();
    } else {
      play();
    }
  }

  Future preparePlayer({required File file}) async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    size.value = file.getStringSize();
    try {
      return audioPlayer.setFilePath(file.path);
    } catch (e) {
      App.logger.e("Error loading audio source: $e");
    }
  }

  pause() async {
    playState.value = PlayState.pause;
    await audioPlayer.pause();
  }

  play() async {
    playState.value = PlayState.play;
    await audioPlayer.play();
    await audioPlayer.pause();
  }
}

class VoiceControllerFlyweight {
  Map<String, VoiceController> voiceControllers = {};

  VoiceController getController(String url) {
    if (!voiceControllers.containsKey(url)) {
      voiceControllers[url] = VoiceController(voiceUrl: url);
      voiceControllers[url]!
          .audioPlayer
          .playerStateStream
          .listen((event) => event.playing ? stopAllPlayers(withOut: url) : voiceControllers[url]!.playState.value = PlayState.pause);
    }

    return voiceControllers[url]!;
  }

  Future stopAllPlayers({String? withOut}) async {
    voiceControllers.forEach(
      (key, controller) async {
        if (key != withOut) {
          if (controller.playState.value == PlayState.play) {
            return await controller.pause();
          }
        }
      },
    );
  }
}
