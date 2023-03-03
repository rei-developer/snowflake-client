import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';

class SignInButtonComponent extends StatelessWidget {
  const SignInButtonComponent(this.authType, {this.callback, Key? key}) : super(key: key);

  final AuthType authType;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) => MaterialButton(
        color: Colors.purple,
        child: Text('${authType.name} Sign-in'),
        onPressed: () => callback?.call(),
      );
}
