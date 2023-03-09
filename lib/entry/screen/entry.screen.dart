import 'package:flutter/material.dart';
import 'package:snowflake_client/common/layout/title.layout.dart';
import 'package:snowflake_client/entry/container/entry.container.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const TitleLayout(EntryContainer());
}
