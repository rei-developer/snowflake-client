import 'package:snowflake_client/auth/dto/sign-in.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';

abstract class IAuthService {
  Future<SignInDto?> signIn([bool isEntry = false]);

  Future<void> setAuthType(AuthType? authType);

  Future<void> setIdToken(String idToken);

  Future<void> setCustomToken(String customToken);

  Future<void> signOut();
}
