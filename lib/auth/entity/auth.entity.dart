import 'package:hive/hive.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';

part 'auth.entity.g.dart';

@HiveType(typeId: 4)
class AuthEntity extends HiveObject {
  AuthEntity(this.authType, this.idToken, this.customToken, this.uid, this.email);

  factory AuthEntity.initial({
    AuthType? authType,
    String? idToken,
    String? customToken,
    String? uid,
    String? email,
  }) =>
      AuthEntity(
        authType,
        idToken,
        customToken,
        uid,
        email,
      );

  @HiveField(0)
  final AuthType? authType;
  @HiveField(1)
  final String? idToken;
  @HiveField(2)
  final String? customToken;
  @HiveField(3)
  final String? uid;
  @HiveField(4)
  final String? email;

  AuthEntity copyWith({
    AuthType? authType,
    String? idToken,
    String? customToken,
    String? uid,
    String? email,
  }) =>
      AuthEntity(
        authType ?? this.authType,
        idToken ?? this.idToken,
        customToken ?? this.customToken,
        uid ?? this.uid,
        email ?? this.email,
      );
}
