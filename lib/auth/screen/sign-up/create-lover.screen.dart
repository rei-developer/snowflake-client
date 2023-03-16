import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/container/sign-up/create-lover.container.dart';
import 'package:snowflake_client/common/layout/title.layout.dart';

class CreateLoverScreen extends StatelessWidget {
  const CreateLoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const TitleLayout(CreateLoverContainer());
}
