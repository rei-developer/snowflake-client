import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/container/sign-up/generate_lover.container.dart';
import 'package:snowflake_client/common/layout/title.layout.dart';

class GenerateLoverScreen extends StatelessWidget {
  const GenerateLoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const TitleLayout(GenerateLoverContainer());
}
