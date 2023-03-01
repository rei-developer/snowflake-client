import 'package:snowflake_client/dictionary/entity/word.entity.dart';

abstract class IDictionaryDummyRepository {
  Future<List<WordEntity>> fetchWords(String name);
}
