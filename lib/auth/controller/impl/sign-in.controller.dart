import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/provider/sign-in.provider.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';
import 'package:snowflake_client/auth/service/sign-in.service.dart';
import 'package:snowflake_client/common/component/loading_indicator.component.dart';
import 'package:snowflake_client/utils/go.util.dart';

class SignInController extends ISignInController {
  SignInController(this.ref, this.context, this.authType);

  final Ref ref;
  final BuildContext context;
  final AuthType? authType;

  IAuthService get _authService => ref.read(authServiceProvider(authType));

  ISignInService get _signInService => ref.read(signInServiceProvider);

  @override
  Future<void> signIn() async {
    try {
      showLoadingIndicator(context);
      await _authService.setAuthType(authType);
      final routeName = await _signInService.signIn();
      if (!context.mounted) {
        return;
      }
      if (routeName == Go(context).currentRouteName) {
        return;
      }
      await Go(context, routeName).replace();
    } finally {
      Go(context).pop();
    }
  }
}
