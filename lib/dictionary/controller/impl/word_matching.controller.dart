import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/component/image_indicator.component.dart';
import 'package:snowflake_client/dictionary/const/word_matching.const.dart';
import 'package:snowflake_client/dictionary/controller/word_matching.controller.dart';
import 'package:snowflake_client/dictionary/dictionary.route.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';
import 'package:snowflake_client/dictionary/model/word_matching.model.dart';
import 'package:snowflake_client/dictionary/provider/word_matching.provider.dart';
import 'package:snowflake_client/dictionary/service/word_matching.service.dart';
import 'package:snowflake_client/utils/go.util.dart';

class WordMatchingController extends IWordMatchingController {
  WordMatchingController(this.ref)
      : _wordMatchingService = ref.read(wordMatchingServiceProvider),
        super(WordMatchingModel.initial());

  final Ref ref;
  final IWordMatchingService _wordMatchingService;

  Timer? _gameTimer;

  @override
  Future<void> setup(BuildContext context, DictionaryEntity dictionary) async {
    print('setup');
    state = WordMatchingModel.initial(dictionary: dictionary);
    await goToWordMatching(context);
  }

  @override
  void init() {
    print('init');
    Future.delayed(Duration.zero, () {
      final questions = _wordMatchingService.setup(state);
      state = state.copyWith(
        maxScore: questions.length * 10,
        questions: questions,
        gameState: WordMatchingGameState.RUNNING,
      );
      _generateCandidates();
      _startGameTimer();
    });
  }

  @override
  void judgment(BuildContext context, WordEntity candidate) {
    if (question == candidate) {
      showImageIndicator(context, message: '정답입니다!');
      _addScore();
    } else {
      showImageIndicator(context, message: '오답입니다...');
      _subLife();
      if (state.life < 1) {
        print('목숨 없네용!!!');
        print('state.life => ${state.life}');
        print('state.maxLife => ${state.maxLife}');
        _stopGameTimer();
        _setGameState(WordMatchingGameState.RESULT);
        return;
      }
    }
    _next(false);
  }

  @override
  Future<void> goToWordMatching(BuildContext context) => Go(context, DictionaryRoute.WORD_MATCHING.name).to();

  @override
  Future<void> goToVocabularyPractice(BuildContext context) =>
      Go(context, DictionaryRoute.VOCABULARY_PRACTICE.name).replace();

  @override
  void clear() {
    print('clear');
    Future.delayed(Duration.zero, () {
      state = WordMatchingModel.initial();
      _stopGameTimer();
    });
  }

  @override
  WordEntity? get question => hasQuestions && state.round <= state.maxRound ? state.questions[state.round - 1] : null;

  @override
  bool get isRunning => state.gameState == WordMatchingGameState.RUNNING;

  @override
  bool get hasQuestions => state.questions.isNotEmpty;

  void _next([bool isTimedOut = true]) {
    print('next');
    _stopGameTimer();
    if (state.round >= state.maxRound) {
      print('end game');
      _setGameState(WordMatchingGameState.RESULT);
      return;
    }
    if (isTimedOut) {
      print('시간 초과입니다');
    }
    state = state.copyWith(round: state.round + 1);
    _generateCandidates();
    _startGameTimer();
  }

  void _generateCandidates() => state = state.copyWith(candidates: _wordMatchingService.generateCandidates(state));

  void _subLife([int value = -1]) => state = state.copyWith(life: state.life + value);

  void _addScore([int value = 10]) => state = state.copyWith(score: state.score + value);

  void _setGameState(WordMatchingGameState gameState) => state = state.copyWith(gameState: gameState);

  void _startGameTimer() {
    print('set game timer');
    _gameTimer = Timer.periodic(
      Duration(seconds: state.timeLimit),
      (_) {
        print('fetched game timer');
        _next();
      },
    );
  }

  void _stopGameTimer() {
    print('stoped game timer');
    _gameTimer?.cancel();
    _gameTimer = null;
  }
}
