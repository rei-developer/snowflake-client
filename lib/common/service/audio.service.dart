import 'package:just_audio/just_audio.dart';

abstract class IAudioService {
  Future<void> set(
    AudioPlayer audioPlayer,
    String path, [
    double volume = 0.8,
    bool isLoop = true,
    bool isPlay = true,
  ]);

  Future<void> play(AudioPlayer audioPlayer);

  Future<void> pause(AudioPlayer audioPlayer);

  Future<void> stop(AudioPlayer audioPlayer);
}
