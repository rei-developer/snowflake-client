import 'package:dio/dio.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.authType, this.token);

  final AuthType? authType;
  final String? token;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (authType == null || token == null) {
      print('AuthInterceptor onRequest error => authType or token does not exist.');
      return;
    }
    options.headers['Authorization'] = '${authType?.name} $token';
    return handler.next(options);
  }
}
