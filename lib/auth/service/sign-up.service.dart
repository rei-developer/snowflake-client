import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/dto/response/sign-in-result.response.dto.dart';

abstract class ISignUpService {
  Future<SignInResultResponseDto> register(RegisterRequestDto registerDto);
}
