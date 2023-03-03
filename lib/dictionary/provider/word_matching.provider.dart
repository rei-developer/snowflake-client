import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/dictionary/controller/impl/word_matching.controller.dart';
import 'package:snowflake_client/dictionary/controller/word_matching.controller.dart';
import 'package:snowflake_client/dictionary/model/word_matching.model.dart';
import 'package:snowflake_client/dictionary/service/impl/word_matching.service.dart';
import 'package:snowflake_client/dictionary/service/word_matching.service.dart';

final wordMatchingControllerProvider = StateNotifierProvider<IWordMatchingController, WordMatchingModel>(
  (ref) => WordMatchingController(ref),
);

final wordMatchingServiceProvider = Provider.autoDispose<IWordMatchingService>((ref) => WordMatchingService(ref));
