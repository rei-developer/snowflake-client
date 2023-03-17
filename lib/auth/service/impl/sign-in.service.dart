import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/auth.route.dart';
import 'package:snowflake_client/auth/const/sign-in.const.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/service/auth-custom.service.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';
import 'package:snowflake_client/auth/service/sign-in.service.dart';
import 'package:snowflake_client/network/controller/network.controller.dart';
import 'package:snowflake_client/network/provider/network.provider.dart';
import 'package:snowflake_client/title/title.route.dart';
import 'package:snowflake_client/utils/json_to_binary.util.dart';

class SignInService extends ISignInService {
  SignInService(this.ref);

  final Ref ref;

  IAuthLocalRepository get _authLocalRepo => ref.read(authLocalRepositoryProvider.notifier);

  IAuthService get _authService =>
      ref.read(authServiceProvider(ref.read(authLocalRepositoryProvider.notifier).authType));

  IAuthCustomService get _authCustomService => ref.read(authCustomServiceProvider);

  ITcpConnectionController get _serviceServer => ref.watch(serviceServerProvider.notifier);

  @override
  Future<String> signIn([bool isEntry = false]) async {
    try {
      if (_authLocalRepo.authType == null) {
        return AuthRoute.SIGN_IN.name;
      }
      if (!isEntry) {
        final verifyDto = await _authService.signIn();
        if (verifyDto == null) {
          await _authService.signOut();
          return AuthRoute.SIGN_IN.name;
        }
      }
      final signInResultDto = await _authCustomService.signIn();
      final isConnected = await _serviceServer.connect();
      if (!isConnected) {
        print("not connected service server");
        return AuthRoute.SIGN_IN.name;
      }
      print(_authLocalRepo.customToken);
      await _serviceServer.sendMessage(
        0,
        jsonToBinary({'token': _authLocalRepo.customToken}),
      );
      return _next(
        signInResultDto?.hasUser == true
            ? signInResultDto?.hasLover == true
                ? SignInResult.completed
                : SignInResult.uncreated
            : SignInResult.unregistered,
      );
    } catch (err) {
      print('SignInService signIn error => $err');
      await _authService.signOut();
      return AuthRoute.SIGN_IN.name;
    }
  }

  String _next(SignInResult signInResult) {
    switch (signInResult) {
      case SignInResult.unregistered:
        return AuthRoute.SIGN_UP.name;
      case SignInResult.uncreated:
        return AuthRoute.CREATE_LOVER.name;
      case SignInResult.completed:
        return TitleRoute.TITLE.name;
      default:
        return AuthRoute.SIGN_IN.name;
    }
  }
}
