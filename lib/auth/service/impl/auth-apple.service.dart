import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:snowflake_client/auth/dto/sign-in.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';

class AuthAppleService extends IAuthService {
  AuthAppleService(this.ref) : _authLocalRepo = ref.read(authLocalRepositoryProvider.notifier);

  final Ref ref;
  final IAuthLocalRepository _authLocalRepo;

  @override
  Future<SignInDto?> signIn([bool isEntry = false]) async {
    try {
      if (_authLocalRepo.idToken != null) {
        // return _verify();
      }
      if (isEntry) {
        return null;
      }
      final auth = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final credential = OAuthProvider('apple.com').credential(
        idToken: auth.identityToken,
        accessToken: auth.authorizationCode,
      );
      final firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signInWithCredential(credential);
      final user = firebaseAuth.currentUser;
      if (user == null) {
        return null;
      }
      final idToken = await user.getIdToken();
      _authLocalRepo
        ..setAuthType(AuthType.APPLE)
        ..setIdToken(idToken);
      print('idToken => $idToken');
      print(user.email);
      return _verify();
    } catch (err) {
      print('AuthAppleService signIn error => $err');
      return null;
    }
  }

  @override
  Future<void> setAuthType(AuthType? authType) => _authLocalRepo.setAuthType(authType);

  @override
  Future<void> setIdToken(String idToken) => _authLocalRepo.setIdToken(idToken);

  @override
  Future<void> setCustomToken(String customToken) => _authLocalRepo.setCustomToken(customToken);

  @override
  Future<void> signOut() => _authLocalRepo.delete();

  Future<SignInDto?> _verify() async {
    try {
      // final data = await ref.read(authRestRepositoryProvider).verify();
      // final uid = data['uid'] as String;
      // final customToken = data['customToken'] as String;
      // ref.read(authControllerProvider.notifier).setUId(uid);
      // ref.read(authLocalRepositoryProvider.notifier)
      //   ..setAuthType(AuthType.GOOGLE)
      //   ..setCustomToken(customToken);
      // await Hive.openBox(uid);
      // return data;

      // final data = await ref.read(authRestRepositoryProvider).verify();
      // final uid = data['uid'] as String;
      // final customToken = data['customToken'] as String;
      // ref.read(authControllerProvider.notifier).setUId(uid);
      // ref.read(authLocalRepositoryProvider.notifier).setCustomToken(customToken);
      // await Hive.openBox(uid);
      // return data;

      return SignInDto.fromJson({});
    } catch (err) {
      print('AuthAppleService verify error => $err');
      return null;
    }
  }
}
