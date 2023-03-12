import 'package:audioplayers/audioplayers.dart';

class AudioStateModel {
  AudioStateModel(
    this.player,
    this.isLoading,
    this.isPlaying,
    this.volume,
  );

  factory AudioStateModel.initial() => AudioStateModel(AudioPlayer(), false, false, 1.0);

  AudioStateModel copyWith({
    AudioPlayer? player,
    bool? isLoading,
    bool? isPlaying,
    double? volume,
  }) =>
      AudioStateModel(
        player ?? this.player,
        isLoading ?? this.isLoading,
        isPlaying ?? this.isPlaying,
        volume ?? this.volume,
      );

  final AudioPlayer player;
  final bool isLoading;
  final bool isPlaying;
  final double volume;
}
