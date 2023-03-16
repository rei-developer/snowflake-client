import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';

abstract class IAuthRestRepository {
  Future<dynamic> verify();

  Future<dynamic> verifyCustom();

  Future<dynamic> register(RegisterRequestDto registerDto);
}
