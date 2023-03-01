import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/dictionary/controller/dictionary.controller.dart';
import 'package:snowflake_client/dictionary/controller/impl/dictionary.controller.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-dummy.repository.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-local.repository.dart';
import 'package:snowflake_client/dictionary/repository/impl/dictionary-dummy.repository.dart';
import 'package:snowflake_client/dictionary/repository/impl/dictionary-local.repository.dart';
import 'package:snowflake_client/dictionary/service/dictionary.service.dart';
import 'package:snowflake_client/dictionary/service/impl/dictionary.service.dart';

final dictionaryControllerProvider = Provider<IDictionaryController>(
  (ref) => DictionaryController(ref),
);

final dictionaryDummyRepositoryProvider = Provider<IDictionaryDummyRepository>(
  (_) => DictionaryDummyRepository(),
);

final dictionaryLocalRepositoryProvider = StateNotifierProvider<IDictionaryLocalRepository, Box>(
  (_) => DictionaryLocalRepository(),
);

final dictionaryServiceProvider = Provider<IDictionaryService>(
  (ref) => DictionaryService(ref),
);
