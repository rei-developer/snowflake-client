import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';

part 'dictionary.entity.g.dart';

@HiveType(typeId: 0)
class DictionaryEntity {
  DictionaryEntity(this.index, this.name, this.words);

  @HiveField(0)
  final int index;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<WordEntity> words;
}
