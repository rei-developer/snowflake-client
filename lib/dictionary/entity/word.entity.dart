import 'package:hive_flutter/hive_flutter.dart';

part 'word.entity.g.dart';

@HiveType(typeId: 1)
class WordEntity {
  WordEntity(this.word, this.definition, this.partOfSpeech);

  @HiveField(0)
  final String word;
  @HiveField(1)
  final String definition;
  @HiveField(2)
  final String partOfSpeech;
}
