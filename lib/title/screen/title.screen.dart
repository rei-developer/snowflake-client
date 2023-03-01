import 'package:flutter/material.dart';
import 'package:snowflake_client/common/layout/title.layout.dart';
import 'package:snowflake_client/title/container/title.container.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const TitleLayout(TitleContainer());
}
