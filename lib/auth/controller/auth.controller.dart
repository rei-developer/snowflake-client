import 'package:snowflake_client/auth/auth.const.dart';

abstract class IAuthController {
  Future<SignInResult> signIn();

  Future<void> signOut();
}
