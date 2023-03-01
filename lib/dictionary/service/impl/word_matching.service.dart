import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';
import 'package:snowflake_client/dictionary/model/word_matching.model.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-local.repository.dart';
import 'package:snowflake_client/dictionary/service/word_matching.service.dart';

import 'dart:math';

class WordMatchingService extends IWordMatchingService {
  WordMatchingService(this.ref)
      : dictionaryLocalRepo = ref.watch(dictionaryLocalRepositoryProvider.notifier);

  final Ref ref;
  final IDictionaryLocalRepository dictionaryLocalRepo;

  @override
  List<WordEntity> setup(WordMatchingModel wordMatching) {
    final questions = _extractRandomQuestions(
      wordMatching.dictionary?.words ?? [],
      wordMatching.maxRound,
    );
    // TODO: 난이도 등 필터링
    return questions;
  }

  @override
  List<WordEntity> generateCandidates(WordMatchingModel wordMatching) {
    try {
      final round = wordMatching.round;
      final words = wordMatching.dictionary?.words ?? [];
      final question = wordMatching.questions[round - 1];
      final candidates = [
        question,
        ..._extractRandomQuestions(
          [...words].where((e) => e != question).toList(),
          3,
        ),
      ];
      candidates.shuffle();
      return candidates;
    } catch (err) {
      print('WordMatchingService generateCandidates error => $err');
      return [];
    }
  }

  List<WordEntity> _extractRandomQuestions(List<WordEntity> words, int count) {
    try {
      final random = Random();
      final List<WordEntity> result = [];
      if (words.length <= count) {
        return words;
      }
      for (int i = 0; i < count; i++) {
        int randomIndex = random.nextInt(words.length);
        result.add(words[randomIndex]);
        words.removeAt(randomIndex);
      }
      return result;
    } catch (err) {
      print('WordMatchingService extractRandomQuestions error => $err');
      return [];
    }
  }
}
