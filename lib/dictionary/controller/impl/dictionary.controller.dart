import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/dictionary/controller/dictionary.controller.dart';
import 'package:snowflake_client/dictionary/dictionary.route.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';
import 'package:snowflake_client/dictionary/service/dictionary.service.dart';
import 'package:snowflake_client/utils/go.util.dart';

class DictionaryController extends IDictionaryController {
  DictionaryController(this.ref) : _dictionaryService = ref.read(dictionaryServiceProvider);

  final Ref ref;
  final IDictionaryService _dictionaryService;

  @override
  Future<void> setup() async {
    final dummyDictionaries = await _dictionaryService.fetchDummyDictionaries();
    for (final item in dummyDictionaries) {
      await _dictionaryService.setup(item);
    }
  }

  @override
  Future<List<DictionaryEntity>> fetchDictionaries() => _dictionaryService.fetchDictionaries();

  @override
  Future<void> goToDictionary(BuildContext context) =>
      Go(context, DictionaryRoute.DICTIONARY.name).replace();

  @override
  Future<void> goToVocabularyPractice(BuildContext context) =>
      Go(context, DictionaryRoute.VOCABULARY_PRACTICE.name).to();
}
