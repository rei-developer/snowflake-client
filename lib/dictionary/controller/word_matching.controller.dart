import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';
import 'package:snowflake_client/dictionary/model/word_matching.model.dart';

abstract class IWordMatchingController extends StateNotifier<WordMatchingModel> {
  IWordMatchingController(super.state);

  Future<void> setup(BuildContext context, DictionaryEntity dictionary);

  void init();

  void clear();

  void judgment(WordEntity candidate);

  Future<void> goToWordMatching(BuildContext context);

  Future<void> goToVocabularyPractice(BuildContext context);

  WordEntity? get question;

  bool get isRunning;

  bool get hasQuestions;
}
