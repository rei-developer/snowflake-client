import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/entity/auth.entity.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/config/hive.config.dart';

class AuthLocalRepository extends IAuthLocalRepository {
  AuthLocalRepository()
      : _key = HiveStorageKey.AUTH.name,
        super(Hive.box(HiveBox.AUTH.name));

  final String _key;

  @override
  Future<void> setAuthType(AuthType? authType) => save(authType: authType);

  @override
  Future<void> setIdToken(String idToken) => save(idToken: idToken);

  @override
  Future<void> setCustomToken(String customToken) => save(customToken: customToken);

  @override
  Future<void> setEmail(String email) => save(email: email);

  @override
  Future<void> save({AuthType? authType, String? idToken, String? customToken, String? email}) =>
      state.put(
        _key,
        _auth.copyWith(
          authType: authType ?? this.authType,
          idToken: idToken ?? this.idToken,
          customToken: customToken ?? this.customToken,
          email: email ?? this.email,
        ),
      );

  @override
  Future<void> delete() => state.delete(_key);

  @override
  AuthType? get authType => _auth.authType;

  @override
  String? get idToken => _auth.idToken;

  @override
  String? get customToken => _auth.customToken;

  @override
  String? get email => _auth.email;

  AuthEntity get _auth => state.get(_key, defaultValue: AuthEntity.initial()) as AuthEntity;
}
