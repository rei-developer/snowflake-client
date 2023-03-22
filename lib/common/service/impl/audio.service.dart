import 'package:just_audio/just_audio.dart';
import 'package:snowflake_client/common/service/audio.service.dart';

class AudioService extends IAudioService {
  @override
  Future<void> set(
    AudioPlayer audioPlayer,
    String path, [
    double volume = 0.8,
    bool isLoop = true,
    bool isPlay = true,
  ]) async {
    await audioPlayer.setAsset('$_prefix/$path');
    await audioPlayer.setVolume(volume);
    await audioPlayer.setLoopMode(LoopMode.all);
    if (isPlay) {
      await play(audioPlayer);
    }
  }

  @override
  Future<void> play(AudioPlayer audioPlayer) async => await audioPlayer.play();

  @override
  Future<void> pause(AudioPlayer audioPlayer) async => await audioPlayer.pause();

  @override
  Future<void> stop(AudioPlayer audioPlayer) async => await audioPlayer.stop();

  String get _prefix => 'assets/audio';
}
