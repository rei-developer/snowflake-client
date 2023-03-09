import 'package:dio/dio.dart';
import 'package:snowflake_client/api/interceptor/app.interceptor.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/interceptor/auth.interceptor.dart';
import 'package:snowflake_client/config/environment.config.dart';

class Api {
  factory Api() => _singleton;

  Api._internal();

  final dio = createDio();
  final externalDio = createExternalDio();
  static final _singleton = Api._internal();

  static Dio createDio() {
    final dio = Dio(_options);
    dio.interceptors.add(AppInterceptor());
    return dio;
  }

  static Dio createExternalDio() {
    final dio = Dio(_options.copyWith(baseUrl: ''));
    dio.interceptors.add(AppInterceptor());
    return dio;
  }

  static Dio createAuthDio(AuthType? authType, String? token) {
    final dio = Dio(_options);
    dio.interceptors.addAll([AppInterceptor(), AuthInterceptor(authType, token)]);
    return dio;
  }

  static BaseOptions get _options => BaseOptions(
        baseUrl: '${Environment.instance.baseUrl}/',
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      );
}
