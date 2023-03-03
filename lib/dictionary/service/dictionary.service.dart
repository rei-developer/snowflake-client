import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';

abstract class IDictionaryService {
  Future<bool> setup(DictionaryEntity dictionary);

  Future<List<DictionaryEntity>> fetchDictionaries();

  Future<List<DictionaryEntity>> fetchDummyDictionaries();
}
