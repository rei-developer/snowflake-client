import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/container/sign-up/sign-up.container.dart';
import 'package:snowflake_client/common/layout/title.layout.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const TitleLayout(SignUpContainer());
}
