import 'package:snowflake_client/auth/dto/response/verify.response.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';

abstract class IAuthService {
  Future<VerifyResponseDto?> signIn();

  Future<void> setAuthType(AuthType? authType);

  Future<void> setIdToken(String idToken);

  Future<void> setCustomToken(String customToken);

  Future<void> setUid(String uid);

  Future<void> setEmail(String email);

  Future<void> signOut();

  String? get uid;
}
