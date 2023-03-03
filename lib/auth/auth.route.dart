import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/screen/sign-in/sign-in.screen.dart';

enum AuthRoute {
  SIGN_IN('/');

  const AuthRoute(this.name);

  final String name;
}

Map<String, WidgetBuilder> getAuthRoutes() => {
      AuthRoute.SIGN_IN.name: (context) => const SignInScreen(),
    };
