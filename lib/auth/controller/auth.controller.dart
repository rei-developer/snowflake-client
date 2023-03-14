import 'package:snowflake_client/auth/auth.const.dart';

abstract class IAuthController {
  Future<SignInResult> signIn();

  Future<bool> register(String name);

  Future<void> signOut();
}
