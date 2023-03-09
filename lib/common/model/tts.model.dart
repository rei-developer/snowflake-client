import 'package:snowflake_client/common/controller/impl/tts.controller.dart';

class TtsModel {
  TtsModel(
    this.language,
    this.engine,
    this.volume,
    this.pitch,
    this.rate,
    this.isCurrentLanguageInstalled,
    this.ttsState,
  );

  factory TtsModel.initial({
    String? language,
    String? engine,
    double? volume,
    double? pitch,
    double? rate,
    bool? isCurrentLanguageInstalled,
    TtsState? ttsState,
  }) =>
      TtsModel(
        language ?? 'en-US',
        engine,
        volume ?? 0.5,
        pitch ?? 1.0,
        rate ?? 0.5,
        isCurrentLanguageInstalled ?? false,
        ttsState ?? TtsState.stopped,
      );

  TtsModel copyWith({
    String? language,
    String? engine,
    double? volume,
    double? pitch,
    double? rate,
    bool? isCurrentLanguageInstalled,
    TtsState? ttsState,
  }) =>
      TtsModel(
        language ?? this.language,
        engine ?? this.engine,
        volume ?? this.volume,
        pitch ?? this.pitch,
        rate ?? this.rate,
        isCurrentLanguageInstalled ?? this.isCurrentLanguageInstalled,
        ttsState ?? this.ttsState,
      );

  final String? language;
  final String? engine;
  final double volume;
  final double pitch;
  final double rate;
  final bool isCurrentLanguageInstalled;
  final TtsState ttsState;
}
