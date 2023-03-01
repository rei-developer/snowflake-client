import 'package:flutter/material.dart';
import 'package:snowflake_client/common/layout/default.layout.dart';
import 'package:snowflake_client/dictionary/container/vocabulary_practice/word_matching.container.dart';

class WordMatchingScreen extends StatelessWidget {
  const WordMatchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const DefaultLayout(WordMatchingContainer());
}
