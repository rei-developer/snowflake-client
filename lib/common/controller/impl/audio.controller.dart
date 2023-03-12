import 'package:audioplayers/audioplayers.dart';
import 'package:snowflake_client/common/controller/audio.controller.dart';
import 'package:snowflake_client/common/model/audio_state.model.dart';

class AudioController extends IAudioController {
  AudioController() : super(AudioStateModel.initial()) {
    state.player.setReleaseMode(ReleaseMode.loop);
    state.player.stop();
  }

  @override
  Future<void> playBGM(String path) async {
    await stopBGM();
    state = state.copyWith(isLoading: true);
    await state.player.setSourceAsset(path);
    await state.player.resume();
    state = state.copyWith(isLoading: false, isPlaying: true);
  }

  @override
  Future<void> playSE(String path) async {
    final player = AudioPlayer();
    await player.setSourceAsset(path);
    await player.setVolume(0.5);
    await player.resume();
  }

  @override
  Future<void> pauseBGM() async {
    await state.player.pause();
    state = state.copyWith(isPlaying: false);
  }

  @override
  Future<void> stopBGM() async {
    await state.player.stop();
    state = state.copyWith(isPlaying: false);
  }

  @override
  Future<void> setVolumeBGM(double volume) async {
    await state.player.setVolume(volume);
    state = state.copyWith(volume: volume);
  }
}
