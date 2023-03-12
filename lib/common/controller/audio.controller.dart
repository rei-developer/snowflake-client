import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/model/audio_state.model.dart';

abstract class IAudioController extends StateNotifier<AudioStateModel> {
  IAudioController(super.state);

  Future<void> playBGM(String path);

  Future<void> playSE(String path);

  Future<void> pauseBGM();

  Future<void> stopBGM();

  Future<void> setVolumeBGM(double volume);
}
