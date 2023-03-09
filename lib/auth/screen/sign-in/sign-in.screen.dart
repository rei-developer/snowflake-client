import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/container/sign-in/sign-in.container.dart';
import 'package:snowflake_client/common/layout/title.layout.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const TitleLayout(SignInContainer());
}
