class AudioStateModel {
  AudioStateModel(
    this.isLoading,
    this.isPlaying,
    this.volume,
  );

  factory AudioStateModel.initial() => AudioStateModel(false, false, 1.0);

  AudioStateModel copyWith({
    bool? isLoading,
    bool? isPlaying,
    double? volume,
  }) =>
      AudioStateModel(
        isLoading ?? this.isLoading,
        isPlaying ?? this.isPlaying,
        volume ?? this.volume,
      );

  final bool isLoading;
  final bool isPlaying;
  final double volume;
}
