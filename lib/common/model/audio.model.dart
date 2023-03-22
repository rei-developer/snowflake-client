import 'package:just_audio/just_audio.dart';

class AudioModel {
  AudioModel(this.bgm, this.bgs);

  factory AudioModel.initial({AudioPlayer? bgm, AudioPlayer? bgs}) =>
      AudioModel(bgm ?? AudioPlayer(), bgs ?? AudioPlayer());

  AudioModel copyWith({AudioPlayer? bgm, AudioPlayer? bgs}) =>
      AudioModel(bgm ?? this.bgm, bgs ?? this.bgs);

  final AudioPlayer bgm;
  final AudioPlayer bgs;
}
