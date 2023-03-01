import 'package:flutter/material.dart';
import 'package:snowflake_client/common/layout/default.layout.dart';
import 'package:snowflake_client/dictionary/container/dictionary.container.dart';

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const DefaultLayout(DictionaryContainer());
}
