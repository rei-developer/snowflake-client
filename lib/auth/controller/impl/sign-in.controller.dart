import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/auth.const.dart';
import 'package:snowflake_client/auth/controller/auth.controller.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';
import 'package:snowflake_client/common/component/dialog/confirm.dialog.dart';
import 'package:snowflake_client/common/component/loading_indicator.component.dart';
import 'package:snowflake_client/title/title.route.dart';
import 'package:snowflake_client/utils/go.util.dart';

class SignInController extends ISignInController {
  SignInController(this.ref, this.context, this.authType)
      : _authCtrl = ref.read(authControllerProvider(authType)),
        _authService = ref.read(authServiceProvider(authType));

  final Ref ref;
  final BuildContext context;
  final AuthType? authType;
  final IAuthController _authCtrl;
  final IAuthService _authService;

  @override
  Future<void> signIn() async {
    showLoadingIndicator(context);
    try {
      switch (await _authCtrl.signIn()) {
        case SignInResult.succeed:
          final uid = _authService.uid;
          print('uid => $uid');
          await goToTitle();
          break;
        case SignInResult.failed:
          await _authCtrl.signOut();
          if (context.mounted) {
            return;
          }
          await showConfirmDialog(context, title: '알림', message: '로그인을 취소했습니다.');
          return;
      }
      // TODO: setup account
      print('go to dictionary screen');
      await goToTitle();
    } catch (err) {
      print('SignInController signIn error => $err');
      await _authCtrl.signOut();
    } finally {
      Go(context).pop();
    }
  }

  @override
  Future<void> goToTitle() => Go(context, TitleRoute.TITLE.name).replace();
}
