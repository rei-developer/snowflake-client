import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/auth.const.dart';
import 'package:snowflake_client/auth/controller/auth.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/model/auth.model.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';

class AuthController extends IAuthController {
  AuthController(this.ref, this.authType)
      : _authService = ref.read(authServiceProvider(authType)),
        super(AuthModel.initial());

  final Ref ref;
  final AuthType? authType;
  final IAuthService _authService;

  @override
  Future<SignInResult> signIn() async {
    try {
      await _authService.setAuthType(authType);
      final signInDto = await _authService.signIn();
      if (signInDto == null) {
        await signOut();
        return SignInResult.failed;
      }
      setUid(signInDto.uid);
      return SignInResult.succeed;
    } catch (err) {
      print('AuthController signIn error => $err');
      await signOut();
      return SignInResult.failed;
    }
  }

  @override
  void setUid([String? uid = '']) => state = state.copyWith(uid: uid);

  @override
  Future<void> signOut() async {
    await _authService.signOut();
    state = AuthModel.initial();
  }

  @override
  String get uid => state.uid;
}
