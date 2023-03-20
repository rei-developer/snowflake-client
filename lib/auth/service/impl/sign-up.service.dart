import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/dto/response/draw_first_lover.dto.dart';
import 'package:snowflake_client/auth/dto/response/sign-in-result.response.dto.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';
import 'package:snowflake_client/auth/repository/sign-up.repository.dart';
import 'package:snowflake_client/auth/service/sign-up.service.dart';

class SignUpService extends ISignUpService {
  SignUpService(this.ref);

  final Ref ref;

  IAuthRestRepository get _authRestRepo => ref.read(authRestRepositoryProvider);

  ISignUpRepository get _signUpRepo => ref.read(signUpStateRepositoryProvider.notifier);

  @override
  Future<SignInResultResponseDto> register(RegisterRequestDto registerDto) async =>
      SignInResultResponseDto.fromJson(await _authRestRepo.register(registerDto));

  @override
  void setDrawFirstLoverHash(Map<String, dynamic> json) =>
      _signUpRepo.setDrawFirstLoverHash(DrawFirstLoverDto.fromJson(json).hash);
}
