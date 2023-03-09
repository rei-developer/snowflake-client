import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:snowflake_client/common/controller/tts.controller.dart';
import 'package:snowflake_client/common/model/tts.model.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsController extends ITtsController {
  TtsController() : super(TtsModel.initial()) {
    tts.setSharedInstance(true);
    if (Platform.isIOS) {
      tts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
    }
    tts.awaitSpeakCompletion(true);
    tts.setVoice({"name": "Karen", "locale": "en-AU"});
    setAwaitOptions();
    if (isAndroid) {
      getDefaultEngine();
      getDefaultVoice();
    }

    tts.setStartHandler(() {
      print("playing");
      state = state?.copyWith(ttsState: TtsState.playing);
    });
    tts.setCompletionHandler(() {
      print('complete');
      state = state?.copyWith(ttsState: TtsState.stopped);
    });
    tts.setCancelHandler(() => state = state?.copyWith(ttsState: TtsState.stopped));
    tts.setPauseHandler(() => state = state?.copyWith(ttsState: TtsState.paused));
    tts.setContinueHandler(() {
      print('continue');
      state = state?.copyWith(ttsState: TtsState.continued);
    });
    print("AAA");
  }

  final FlutterTts tts = FlutterTts();

  @override
  Future<dynamic> getLanguages() async => await tts.getLanguages;

  @override
  Future<dynamic> getEngines() async => await tts.getEngines;

  @override
  Future<void> getDefaultEngine() async {
    // final engine = await tts.getDefaultEngine;
    // if (engine != null) {
    //   print(engine);
    //   state = state?.copyWith(engine: engine);
    // }
  }

  @override
  Future<void> getDefaultVoice() async {
    // final voice = await tts.getDefaultVoice;
    // if (voice != null) {
    //   print(voice);
    // }
  }

  @override
  Future<void> speak(String? text) async {
    await tts.setVolume(state?.volume ?? 1.0);
    await tts.setSpeechRate(state?.rate ?? 1.0);
    await tts.setPitch(state?.pitch ?? 1.0);
    if (text == null || text.isEmpty) return;
    print(text);
    try {
      await tts.speak(text);
      print("C");
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> setLanguage(String language) async {
    await tts.setLanguage(language);
  }

  @override
  Future<void> setAwaitOptions() async {
    await tts.awaitSpeakCompletion(true);
  }

  @override
  Future<void> stop() async {
    final result = await tts.stop();
    if (result == 1) state = state?.copyWith(ttsState: TtsState.stopped);
  }

  @override
  Future<void> pause() async {
    final result = await tts.pause();
    if (result == 1) state = state?.copyWith(ttsState: TtsState.paused);
  }

  @override
  bool get isPlaying => state?.ttsState == TtsState.playing;

  @override
  bool get isStopped => state?.ttsState == TtsState.stopped;

  @override
  bool get isPaused => state?.ttsState == TtsState.paused;

  @override
  bool get isContinued => state?.ttsState == TtsState.continued;

  @override
  bool get isAndroid => Platform.isAndroid;

  @override
  bool get isIOS => Platform.isIOS;
}
