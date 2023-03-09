import 'package:audioplayers/audioplayers.dart';
import 'package:snowflake_client/common/controller/audio.controller.dart';
import 'package:snowflake_client/common/model/audio_state.model.dart';

class AudioController extends IAudioController {
  AudioController() : super(AudioStateModel.initial()) {
    _audioPlayer = AudioPlayer();
  }

  AudioPlayer? _audioPlayer;

  @override
  Future<void> play(String path) async {
    state = state.copyWith(isLoading: true);
    await stop();
    await _audioPlayer?.dispose();
    await _audioPlayer?.setSourceAsset(path);
    await setVolume(state.volume);
    await _audioPlayer?.resume();
    state = state.copyWith(isLoading: false, isPlaying: true);
  }

  @override
  Future<void> pause() async {
    await _audioPlayer?.pause();
    state = state.copyWith(isPlaying: false);
  }

  @override
  Future<void> stop() async {
    await _audioPlayer?.stop();
    state = state.copyWith(isPlaying: false);
  }

  @override
  Future<void> setVolume(double volume) async {
    await _audioPlayer?.setVolume(volume);
    state = state.copyWith(volume: volume);
  }
}
