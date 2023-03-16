import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/dto/response/sign-in-result.response.dto.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';
import 'package:snowflake_client/auth/service/auth-custom.service.dart';

class AuthCustomService extends IAuthCustomService {
  AuthCustomService(this.ref);

  final Ref ref;

  IAuthRestRepository get _authRestRepo => ref.read(authRestRepositoryProvider);

  IAuthLocalRepository get _authLocalRepo => ref.read(authLocalRepositoryProvider.notifier);

  @override
  Future<SignInResultResponseDto?> signIn() async {
    try {
      if (_authLocalRepo.customToken == null) {
        return null;
      }
      final signInResultDto = SignInResultResponseDto.fromJson(await _authRestRepo.verifyCustom());
      await Hive.openBox(signInResultDto.uid);
      return signInResultDto;
    } catch (err) {
      print('AuthCustomService signIn error => $err');
      return null;
    }
  }
}
