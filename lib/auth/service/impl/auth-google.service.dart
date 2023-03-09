import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/dto/sign-in.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';
import 'package:snowflake_client/firebase_options.dart';

class AuthGoogleService extends IAuthService {
  AuthGoogleService(this.ref)
      : _googleAuth = GoogleSignIn(
          clientId: defaultTargetPlatform == TargetPlatform.iOS
              ? DefaultFirebaseOptions.currentPlatform.iosClientId
              : DefaultFirebaseOptions.currentPlatform.androidClientId,
        ),
        _firebaseAuth = FirebaseAuth.instance,
        _authRestRepo = ref.read(authRestRepositoryProvider),
        _authLocalRepo = ref.read(authLocalRepositoryProvider.notifier);

  final Ref ref;
  final GoogleSignIn _googleAuth;
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
      final auth = await (await _googleAuth.signIn())?.authentication;
      if (auth == null) {
        return null;
      }
      await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(idToken: auth.idToken, accessToken: auth.accessToken),
      );
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return null;
      }
      final idToken = await user.getIdToken();
      this
        ..setAuthType(AuthType.GOOGLE)
        ..setIdToken(idToken)
        ..setEmail(user.email ?? '');
      return _verify();
    } catch (err) {
      print('AuthGoogleService signIn error => $err');
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
  Future<void> setEmail(String email) => _authLocalRepo.setEmail(email);

  @override
  Future<void> signOut() async {
    if (await _googleAuth.isSignedIn()) {
      await _googleAuth.disconnect();
    }
    await _authLocalRepo.delete();
  }

  Future<SignInDto?> _verify() async {
    try {
      final signInDto = SignInDto.fromJson(await _authRestRepo.verify());
      await setCustomToken(signInDto.customToken);
      await Hive.openBox(signInDto.uid);
      return signInDto;
    } catch (err) {
      print('AuthGoogleService verify error => $err');
      return null;
    }
  }
}
