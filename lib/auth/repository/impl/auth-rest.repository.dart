import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snowflake_client/api/api.const.dart';
import 'package:snowflake_client/api/api.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';

class AuthRestRepository extends IAuthRestRepository {
  AuthRestRepository(this.authLocalRepo) : _route = RoutePath.AUTH.name;
  final IAuthLocalRepository authLocalRepo;
  final String _route;

  Dio get _authApi => Api.createAuthDio(authLocalRepo.authType, authLocalRepo.idToken);

  Dio get _customAuthApi => Api.createAuthDio(AuthType.LOCAL, authLocalRepo.customToken);

  @override
  Future<dynamic> verify() async => (await _authApi.get('$_route/verify')).data;

  @override
  Future<dynamic> verifyCustom() async => (await _customAuthApi.get('$_route/verify/custom')).data;

  @override
  Future<dynamic> register(RegisterRequestDto registerDto) async =>
      (await _customAuthApi.post('$_route/register', data: jsonEncode(registerDto.toJson()))).data;
}
