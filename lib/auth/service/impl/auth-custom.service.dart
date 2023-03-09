import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/dto/sign-in.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';

class AuthCustomService extends IAuthService {
  AuthCustomService(this.ref)
      : _authRestRepo = ref.watch(authRestRepositoryProvider),
        _authLocalRepo = ref.watch(authLocalRepositoryProvider.notifier);

  final Ref ref;
  final IAuthRestRepository _authRestRepo;
  final IAuthLocalRepository _authLocalRepo;

  @override
  Future<SignInDto?> signIn([bool isEntry = false]) async {
    try {
      if (_authLocalRepo.customToken == null) {
        return null;
      }
      final signInDto = SignInDto.fromJson(await _authRestRepo.verifyCustom());
      await Hive.openBox(signInDto.uid);
      return signInDto;
    } catch (err) {
      print('AuthCustomService signIn error => $err');
      return null;
    }
  }

  @override
  Future<void> setAuthType(AuthType? authType) async {}

  @override
  Future<void> setIdToken(String idToken) async {}

  @override
  Future<void> setCustomToken(String customToken) async {}

  @override
  Future<void> setUid(String uid) async {}

  @override
  Future<void> setEmail(String email) async {}

  @override
  Future<void> signOut() => _authLocalRepo.delete();

  @override
  String? get uid => _authLocalRepo.uid;
}
