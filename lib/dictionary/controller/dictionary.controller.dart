import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';

abstract class IDictionaryController {
  Future<void> setup();

  Future<List<DictionaryEntity>> fetchDictionaries();

  Future<void> goToDictionary();

  Future<void> goToVocabularyPractice();
}
