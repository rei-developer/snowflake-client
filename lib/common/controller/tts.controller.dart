import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/model/tts.model.dart';

abstract class ITtsController extends StateNotifier<TtsModel?> {
  ITtsController(super.state);

  Future<dynamic> getLanguages();

  Future<dynamic> getEngines();

  Future<void> getDefaultEngine();

  Future<void> getDefaultVoice();

  Future<void> speak(String? text);

  Future<void> setLanguage(String language);

  Future<void> setAwaitOptions();

  Future<void> stop();

  Future<void> pause();

  bool get isPlaying;

  bool get isStopped;

  bool get isPaused;

  bool get isContinued;

  bool get isAndroid;

  bool get isIOS;
}
