import 'package:snowflake_client/auth/dto/response/sign-in_result.response.dto.dart';

abstract class IAuthCustomService {
  Future<SignInResultResponseDto?> signIn();
}
