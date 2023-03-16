import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';

abstract class ISignUpController {
  Future<void> register(RegisterRequestDto registerDto);
}
