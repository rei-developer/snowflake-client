import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/dto/sign-in.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';

class AuthFacebookService extends IAuthService {
  AuthFacebookService(this.ref)
      : _facebookAuth = FacebookAuth.instance,
        _firebaseAuth = FirebaseAuth.instance,
        _authLocalRepo = ref.read(authLocalRepositoryProvider.notifier);

  final Ref ref;
  final FacebookAuth _facebookAuth;
  final FirebaseAuth _firebaseAuth;
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
      _authLocalRepo
        ..setAuthType(AuthType.FACEBOOK)
        ..setIdToken(idToken);
      print('idToken => $idToken');
      print(user.email);
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
  Future<void> signOut() async {
    _facebookAuth.logOut();
    _authLocalRepo.delete();
  }

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
      print('AuthFacebookService verify error => $err');
      return null;
    }
  }
}
