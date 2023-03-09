import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/auth.route.dart';
import 'package:snowflake_client/auth/controller/auth.controller.dart';
import 'package:snowflake_client/auth/dto/sign-in.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';
import 'package:snowflake_client/common/component/dialog/confirm.dialog.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/common/service/system.service.dart';
import 'package:snowflake_client/entry/controller/entry.controller.dart';
import 'package:snowflake_client/title/title.route.dart';
import 'package:snowflake_client/utils/go.util.dart';

class EntryController extends IEntryController {
  EntryController(this.ref, this.context)
      : _firebaseAuth = FirebaseAuth.instance,
        _authCtrl = ref.read(
          authControllerProvider(
            ref.read(authLocalRepositoryProvider.notifier).authType,
          ),
        ),
        _authLocalRepo = ref.read(authLocalRepositoryProvider.notifier),
        _authService = ref.read(
          authServiceProvider(
            ref.read(authLocalRepositoryProvider.notifier).authType,
          ),
        ),
        _authCustomService = ref.read(authServiceProvider(AuthType.LOCAL)),
        _systemService = ref.read(systemServiceProvider.notifier),
        super(true);

  final Ref ref;
  final BuildContext context;
  final FirebaseAuth _firebaseAuth;
  final IAuthController _authCtrl;
  final IAuthLocalRepository _authLocalRepo;
  final IAuthService _authService;
  final IAuthService _authCustomService;
  final ISystemService _systemService;

  @override
  Future<bool> init() async {
    try {
      final authType = _authLocalRepo.authType;
      if (authType == null) {
        return false;
      }
      SignInDto? signInDto = await _authCustomService.signIn();
      if (signInDto == null) {
        signInDto = await _authService.signIn(true);
        if (signInDto == null) {
          await _authCtrl.signOut();
          return false;
        }
      }
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return false;
      }
      return Future(() => true);
    } catch (err) {
      print('EntryController init error => $err');
      return false;
    }
  }

  @override
  Future<void> next() async =>
      Go(context, await init() ? TitleRoute.TITLE.name : AuthRoute.SIGN_IN.name).replace();

  @override
  Future<void> checkConnection() async {
    if (await _systemService.isConnected) {
      await next();
      return;
    }
    if (await showConfirmDialog(
      context,
      title: '연결 불가',
      message: '인터넷 연결이 불량합니다. 네트워크를 확인하십시오.',
      cancelButtonLabel: '종료',
      confirmButtonLabel: '재연결',
    )) {
      await Future.delayed(const Duration(seconds: 5));
      await checkConnection();
      return;
    }
    await _systemService.shutdown(true);
  }
}
