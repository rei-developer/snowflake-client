import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snowflake_client/common/controller/audio.controller.dart';
import 'package:snowflake_client/common/controller/impl/audio.controller.dart';
import 'package:snowflake_client/common/controller/impl/tts.controller.dart';
import 'package:snowflake_client/common/controller/tts.controller.dart';
import 'package:snowflake_client/common/model/audio.model.dart';
import 'package:snowflake_client/common/model/tts.model.dart';
import 'package:snowflake_client/common/service/audio.service.dart';
import 'package:snowflake_client/common/service/impl/audio.service.dart';
import 'package:snowflake_client/common/service/impl/system.service.dart';
import 'package:snowflake_client/common/service/system.service.dart';
import 'package:snowflake_client/i18n/strings.g.dart';

final audioControllerProvider = StateNotifierProvider<IAudioController, AudioModel>(
  (ref) => AudioController(ref.watch(audioServiceProvider)),
);

final toastControllerProvider = Provider(
  (_) => (String message) => Fluttertoast.showToast(msg: message),
);

final ttsControllerProvider = StateNotifierProvider<ITtsController, TtsModel?>(
  (_) => TtsController(),
);

final audioServiceProvider = Provider<IAudioService>((_) => AudioService());

final systemServiceProvider = StateNotifierProvider<ISystemService, DateTime>(
  (_) => SystemService(),
);

final StateProvider<StringsEn> translationProvider = StateProvider<StringsEn>(
  (ref) {
    // TODO: lang
    // final system = ref.watch(systemControllerProvider);
    // system?.lang ?? 'ko'
    return AppLocaleUtils.parse('en').build();
  },
);
