import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/dto/response/verify.response.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';

class AuthFacebookService extends IAuthService {
  AuthFacebookService(this.ref)
      : _facebookAuth = FacebookAuth.instance,
        _firebaseAuth = FirebaseAuth.instance;

  final Ref ref;
  final FacebookAuth _facebookAuth;
  final FirebaseAuth _firebaseAuth;

  IAuthRestRepository get _authRestRepo => ref.read(authRestRepositoryProvider);

  IAuthLocalRepository get _authLocalRepo => ref.read(authLocalRepositoryProvider.notifier);

  @override
  Future<VerifyResponseDto?> signIn() async {
    try {
      if (_authLocalRepo.idToken != null) {
        return _verify();
      }
      final accessToken = (await _facebookAuth.login()).accessToken?.token;
      if (accessToken == null) {
        return null;
      }
      await _firebaseAuth.signInWithCredential(FacebookAuthProvider.credential(accessToken));
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return null;
      }
      final idToken = await user.getIdToken();
      this
        ..setAuthType(AuthType.FACEBOOK)
        ..setIdToken(idToken)
        ..setUid(user.uid)
        ..setEmail(user.email ?? '');
      return _verify();
    } catch (err) {
      print('AuthFacebookService signIn error => $err');
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
  Future<void> signOut() async {
    _facebookAuth.logOut();
    _authLocalRepo.delete();
  }

  @override
  String? get uid => _authLocalRepo.uid;

  Future<VerifyResponseDto?> _verify() async {
    try {
      final verifyDto = VerifyResponseDto.fromJson(await _authRestRepo.verify());
      await setCustomToken(verifyDto.customToken);
      await Hive.openBox(verifyDto.uid);
      return verifyDto;
    } catch (err) {
      print('AuthFacebookService verify error => $err');
      return null;
    }
  }
}
