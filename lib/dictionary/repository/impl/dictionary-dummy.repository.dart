import 'package:fast_csv/fast_csv.dart' as fast_csv;
import 'package:flutter/services.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-dummy.repository.dart';

class DictionaryDummyRepository extends IDictionaryDummyRepository {
  @override
  Future<List<WordEntity>> fetchWords(String name) async {
    final rows = fast_csv.parse(
      await rootBundle.loadString('assets/dictionary/$name.csv'),
    );
    final words = <WordEntity>[];
    for (final row in rows) {
      final word = WordEntity(
        row[0].toString(),
        row[1].toString(),
        row[2].toString(),
      );
      words.add(word);
    }
    return words;
  }
}
