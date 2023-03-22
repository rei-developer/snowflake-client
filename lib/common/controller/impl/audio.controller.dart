import 'package:just_audio/just_audio.dart';
import 'package:snowflake_client/common/controller/audio.controller.dart';
import 'package:snowflake_client/common/model/audio.model.dart';
import 'package:snowflake_client/common/service/audio.service.dart';

class AudioController extends IAudioController {
  AudioController(this.audioService) : super(AudioModel.initial());

  final IAudioService audioService;

  @override
  Future<void> setBGM(String path, [double volume = 0.8]) async =>
      await audioService.set(_bgm, path, volume, true, true);

  @override
  Future<void> setBGS(String path, [double volume = 0.8]) async =>
      await audioService.set(_bgs, path, volume, true, true);

  @override
  Future<void> setSE(String path, [double volume = 0.8]) async =>
      await audioService.set(AudioPlayer(), path, volume, false, true);

  @override
  Future<void> playBGM() async => await audioService.play(_bgm);

  @override
  Future<void> playBGS() async => await audioService.play(_bgs);

  @override
  Future<void> pauseBGM() async => await audioService.pause(_bgm);

  @override
  Future<void> pauseBGS() async => await audioService.pause(_bgs);

  @override
  Future<void> stopBGM() async => await audioService.stop(_bgm);

  @override
  Future<void> stopBGS() async => await audioService.stop(_bgs);

  AudioPlayer get _bgm => state.bgm;

  AudioPlayer get _bgs => state.bgs;
}
