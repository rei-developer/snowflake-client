import 'package:dio/dio.dart';
import 'package:snowflake_client/api/api.const.dart';
import 'package:snowflake_client/api/api.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';

class AuthRestRepository extends IAuthRestRepository {
  AuthRestRepository(this.authLocalRepo) : _route = RoutePath.AUTH.name;
  final IAuthLocalRepository authLocalRepo;
  final String _route;

  @override
  Future<dynamic> verify() async => (await _authApi.get('$_route/verify')).data;

  @override
  Future<dynamic> verifyCustom() async => (await _customAuthApi.get('$_route/verify/custom')).data;

  @override
  Future<dynamic> register(String name) async => (await _authApi.post(
        '$_route/register',
        data: {'name': name},
      ))
          .data;

  @override
  Future<dynamic> withdraw() async => (await _authApi.delete('$_route/withdraw')).data;

  Dio get _authApi => Api.createAuthDio(authLocalRepo.authType, authLocalRepo.idToken);

  Dio get _customAuthApi => Api.createAuthDio(AuthType.LOCAL, authLocalRepo.customToken);
}
