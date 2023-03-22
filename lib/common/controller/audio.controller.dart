import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/model/audio.model.dart';

abstract class IAudioController extends StateNotifier<AudioModel> {
  IAudioController(super.state);

  Future<void> setBGM(String path, [double volume = 0.8]);

  Future<void> setBGS(String path, [double volume = 0.8]);

  Future<void> setSE(String path, [double volume = 0.8]);

  Future<void> playBGM();

  Future<void> playBGS();

  Future<void> pauseBGM();

  Future<void> pauseBGS();

  Future<void> stopBGM();

  Future<void> stopBGS();
}
