import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/model/audio_state.model.dart';

abstract class IAudioController extends StateNotifier<AudioStateModel> {
  IAudioController(super.state);

  Future<void> play(String path);

  Future<void> pause();

  Future<void> stop();

  Future<void> setVolume(double volume);
}
