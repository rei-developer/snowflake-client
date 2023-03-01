import 'package:flutter/material.dart';
import 'package:snowflake_client/common/layout/default.layout.dart';
import 'package:snowflake_client/dictionary/container/vocabulary_practice/vocabulary_practice.container.dart';

class VocabularyPracticeScreen extends StatelessWidget {
  const VocabularyPracticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const DefaultLayout(VocabularyPracticeContainer());
}
