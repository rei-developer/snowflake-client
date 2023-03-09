import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:snowflake_client/auth/dto/sign-in.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';

class AuthAppleService extends IAuthService {
  AuthAppleService(this.ref)
      : _firebaseAuth = FirebaseAuth.instance,
        _authRestRepo = ref.read(authRestRepositoryProvider),
        _authLocalRepo = ref.read(authLocalRepositoryProvider.notifier);

  final Ref ref;
  final FirebaseAuth _firebaseAuth;
  final IAuthRestRepository _authRestRepo;
  final IAuthLocalRepository _authLocalRepo;

  @override
  Future<SignInDto?> signIn([bool isEntry = false]) async {
    try {
      if (_authLocalRepo.idToken != null) {
        return _verify();
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
      await _firebaseAuth.signInWithCredential(
        OAuthProvider('apple.com').credential(
          idToken: auth.identityToken,
          accessToken: auth.authorizationCode,
        ),
      );
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return null;
      }
      final idToken = await user.getIdToken();
      this
        ..setAuthType(AuthType.APPLE)
        ..setIdToken(idToken)
        ..setUid(user.uid)
        ..setEmail(user.email ?? '');
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
  Future<void> setUid(String uid) => _authLocalRepo.setUid(uid);

  @override
  Future<void> setEmail(String email) => _authLocalRepo.setEmail(email);

  @override
  Future<void> signOut() => _authLocalRepo.delete();

  @override
  String? get uid => _authLocalRepo.uid;

  Future<SignInDto?> _verify() async {
    try {
      final signInDto = SignInDto.fromJson(await _authRestRepo.verify());
      await setCustomToken(signInDto.customToken);
      await Hive.openBox(signInDto.uid);
      return signInDto;
    } catch (err) {
      print('AuthAppleService verify error => $err');
      return null;
    }
  }
}
