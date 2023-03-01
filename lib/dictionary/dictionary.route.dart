import 'package:flutter/material.dart';
import 'package:snowflake_client/dictionary/screen/dictionary.screen.dart';
import 'package:snowflake_client/dictionary/screen/vocabulary_practice/vocabulary_practice.screen.dart';
import 'package:snowflake_client/dictionary/screen/vocabulary_practice/word_matching.screen.dart';

enum DictionaryRoute {
  DICTIONARY('/dictionary'),
  VOCABULARY_PRACTICE('/vocabulary-practice'),
  WORD_MATCHING('/word-matching');

  const DictionaryRoute(this.name);

  final String name;
}

Map<String, WidgetBuilder> getDictionaryRoutes() => {
      DictionaryRoute.DICTIONARY.name: (context) => const DictionaryScreen(),
      DictionaryRoute.VOCABULARY_PRACTICE.name: (context) => const VocabularyPracticeScreen(),
      DictionaryRoute.WORD_MATCHING.name: (context) => const WordMatchingScreen(),
    };
