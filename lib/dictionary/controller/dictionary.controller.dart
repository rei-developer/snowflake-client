import 'package:flutter/material.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';

abstract class IDictionaryController {
  Future<void> setup();

  Future<List<DictionaryEntity>> fetchDictionaries();

  Future<void> goToDictionary(BuildContext context);

  Future<void> goToVocabularyPractice(BuildContext context);

  Future<void> goToWordMatching(BuildContext context, int index);
}
