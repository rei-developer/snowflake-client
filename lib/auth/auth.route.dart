import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/screen/sign-in/sign-in.screen.dart';
import 'package:snowflake_client/auth/screen/sign-up/generate_lover.screen.dart';
import 'package:snowflake_client/auth/screen/sign-up/sign-up.screen.dart';

enum AuthRoute {
  SIGN_IN('/sign-in'),
  SIGN_UP('/sign-up'),
  GENERATE_LOVER('/generate-lover');

  const AuthRoute(this.name);

  final String name;
}

Map<String, WidgetBuilder> getAuthRoutes() => {
      AuthRoute.SIGN_IN.name: (context) => const SignInScreen(),
      AuthRoute.SIGN_UP.name: (context) => const SignUpScreen(),
      AuthRoute.GENERATE_LOVER.name: (context) => const GenerateLoverScreen(),
    };
