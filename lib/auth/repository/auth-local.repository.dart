import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';

abstract class IAuthLocalRepository extends StateNotifier<Box> {
  IAuthLocalRepository(super.state);

  Future<void> setAuthType(AuthType? authType);

  Future<void> setIdToken(String idToken);

  Future<void> setCustomToken(String customToken);

  Future<void> setUid(String uid);

  Future<void> setEmail(String email);

  Future<void> save({
    AuthType? authType,
    String? idToken,
    String? customToken,
    String? uid,
    String? email,
  });

  Future<void> delete();

  AuthType? get authType;

  String? get idToken;

  String? get customToken;

  String? get uid;

  String? get email;
}
