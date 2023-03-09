import 'package:snowflake_client/dictionary/const/word_matching.const.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';

class WordMatchingModel {
  WordMatchingModel(
    this.dictionary,
    this.round,
    this.maxRound,
    this.life,
    this.maxLife,
    this.score,
    this.maxScore,
    this.timeLimit,
    this.candidates,
    this.questions,
    this.gameState,
  );

  factory WordMatchingModel.initial({
    DictionaryEntity? dictionary,
    int? round,
    int? maxRound,
    int? life,
    int? maxLife,
    int? score,
    int? maxScore,
    int? timeLimit,
    List<WordEntity>? candidates,
    List<WordEntity>? questions,
    WordMatchingGameState? gameState,
  }) =>
      WordMatchingModel(
        dictionary,
        round ?? 1,
        maxRound ?? 30,
        life ?? 10,
        maxLife ?? 10,
        score ?? 0,
        maxScore ?? 30,
        timeLimit ?? 10,
        candidates ?? [],
        questions ?? [],
        gameState ?? WordMatchingGameState.NONE,
      );

  WordMatchingModel copyWith({
    DictionaryEntity? dictionary,
    int? round,
    int? maxRound,
    int? life,
    int? maxLife,
    int? score,
    int? maxScore,
    int? timeLimit,
    List<WordEntity>? candidates,
    List<WordEntity>? questions,
    WordMatchingGameState? gameState,
  }) =>
      WordMatchingModel(
        dictionary ?? this.dictionary,
        round ?? this.round,
        maxRound ?? this.maxRound,
        life ?? this.life,
        maxLife ?? this.maxLife,
        score ?? this.score,
        maxScore ?? this.maxScore,
        timeLimit ?? this.timeLimit,
        candidates ?? this.candidates,
        questions ?? this.questions,
        gameState ?? this.gameState,
      );

  final DictionaryEntity? dictionary;
  final int round;
  final int maxRound;
  final int life;
  final int maxLife;
  final int score;
  final int maxScore;
  final int timeLimit;
  final List<WordEntity> candidates;
  final List<WordEntity> questions;
  final WordMatchingGameState gameState;
}
