import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/component/image_indicator.component.dart';
import 'package:snowflake_client/common/controller/audio.controller.dart';
import 'package:snowflake_client/common/controller/tts.controller.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/dictionary/const/word_matching.const.dart';
import 'package:snowflake_client/dictionary/controller/word_matching.controller.dart';
import 'package:snowflake_client/dictionary/dictionary.route.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';
import 'package:snowflake_client/dictionary/model/word_matching.model.dart';
import 'package:snowflake_client/dictionary/provider/word_matching.provider.dart';
import 'package:snowflake_client/dictionary/service/word_matching.service.dart';
import 'package:snowflake_client/util/go.util.dart';

class WordMatchingController extends IWordMatchingController {
  WordMatchingController(this.ref)
      : _audioCtrl = ref.read(audioControllerProvider.notifier),
        _ttsCtrl = ref.read(ttsControllerProvider.notifier),
        _wordMatchingService = ref.read(wordMatchingServiceProvider),
        super(WordMatchingModel.initial());

  final Ref ref;
  final IAudioController _audioCtrl;
  final ITtsController _ttsCtrl;
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
    Future.delayed(Duration.zero, () async {
      final questions = _wordMatchingService.setup(state);
      state = state.copyWith(
        maxScore: questions.length * 10,
        questions: questions,
        gameState: WordMatchingGameState.RUNNING,
      );
      _generateCandidates();
      await _ttsCtrl.setLanguage('ru-RU');
      await _start();
    });
  }

  @override
  Future<void> judgment(BuildContext context, WordEntity candidate) async {
    if (question == candidate) {
      _audioCtrl.setSE('se/correct.mp3');
      showImageIndicator(context, message: 'Good!');
      _addScore();
    } else {
      _audioCtrl.setSE('se/wrong.mp3');
      showImageIndicator(context, message: 'Bad...');
      _subLife();
      if (state.life < 1) {
        print('state.life => ${state.life}');
        print('state.maxLife => ${state.maxLife}');
        _stop();
        _setGameState(WordMatchingGameState.RESULT);
        return;
      }
    }
    await _next(false);
  }

  @override
  Future<void> goToWordMatching(BuildContext context) =>
      Go(context, DictionaryRoute.WORD_MATCHING.name).to();

  @override
  Future<void> goToVocabularyPractice(BuildContext context) =>
      Go(context, DictionaryRoute.VOCABULARY_PRACTICE.name).replace();

  @override
  void clear() {
    print('clear');
    Future.delayed(Duration.zero, () {
      state = WordMatchingModel.initial();
      _stop();
    });
  }

  @override
  WordEntity? get question =>
      hasQuestions && state.round <= state.maxRound ? state.questions[state.round - 1] : null;

  @override
  bool get isRunning => state.gameState == WordMatchingGameState.RUNNING || isPending;

  @override
  bool get isPending => state.gameState == WordMatchingGameState.PENDING;

  @override
  bool get hasQuestions => state.questions.isNotEmpty;

  Future<void> _next([bool isTimedOut = true]) async {
    _setGameState(WordMatchingGameState.PENDING);
    if (isTimedOut) {
      _audioCtrl.setSE('se/wrong.mp3');
      _subLife();
    }
    // await _ttsCtrl.speak(question?.word);
    await Future.delayed(const Duration(seconds: 1));
    print('next');
    _stop();
    if (state.round >= state.maxRound || state.life < 1) {
      print('end game');
      _setGameState(WordMatchingGameState.RESULT);
      return;
    }
    state = state.copyWith(round: state.round + 1);
    _generateCandidates();
    _start();
  }

  void _generateCandidates() =>
      state = state.copyWith(candidates: _wordMatchingService.generateCandidates(state));

  void _subLife([int value = -1]) => state = state.copyWith(life: state.life + value);

  void _addScore([int value = 10]) => state = state.copyWith(score: state.score + value);

  void _setGameState(WordMatchingGameState gameState) =>
      state = state.copyWith(gameState: gameState);

  Future<void> _start() async {
    print('set game timer');
    _setGameState(WordMatchingGameState.RUNNING);
    if (question?.word != null) {
      print('question?.word => ${question?.word} start tts');
      await _ttsCtrl.speak(question?.word);
    }
    _gameTimer = Timer.periodic(
      Duration(seconds: state.timeLimit),
      (_) async {
        print('fetched game timer');
        await _next();
      },
    );
  }

  void _stop() {
    print('stoped game timer');
    _gameTimer?.cancel();
    _gameTimer = null;
  }
}
