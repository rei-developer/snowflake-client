import 'package:hive_flutter/hive_flutter.dart';

part 'vocabulary_practice.entity.g.dart';

@HiveType(typeId: 2)
class VocabularyPracticeEntity {
  VocabularyPracticeEntity(this.maxRound, this.maxLife, this.timeLimit);

  @HiveField(0)
  final int maxRound;
  @HiveField(1)
  final int maxLife;
  @HiveField(2)
  final int timeLimit;
}
