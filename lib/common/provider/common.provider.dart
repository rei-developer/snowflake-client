import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snowflake_client/common/controller/audio.controller.dart';
import 'package:snowflake_client/common/controller/impl/audio.controller.dart';
import 'package:snowflake_client/common/controller/impl/tts.controller.dart';
import 'package:snowflake_client/common/controller/tts.controller.dart';
import 'package:snowflake_client/common/model/audio_state.model.dart';
import 'package:snowflake_client/common/model/tts.model.dart';
import 'package:snowflake_client/common/service/impl/system.service.dart';
import 'package:snowflake_client/common/service/system.service.dart';

final audioControllerProvider = StateNotifierProvider<IAudioController, AudioStateModel>(
  (_) => AudioController(),
);

final toastControllerProvider = Provider(
  (_) => (String message) => Fluttertoast.showToast(msg: message),
);

final ttsControllerProvider = StateNotifierProvider<ITtsController, TtsModel?>(
  (_) => TtsController(),
);

final systemServiceProvider = StateNotifierProvider<ISystemService, DateTime>(
  (_) => SystemService(),
);
