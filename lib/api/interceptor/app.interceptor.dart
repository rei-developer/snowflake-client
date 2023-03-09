import 'package:dio/dio.dart';
import 'package:snowflake_client/api/exception/bad-request.exception.dart';
import 'package:snowflake_client/api/exception/conflict.exception.dart';
import 'package:snowflake_client/api/exception/deadline-exceeded.exception.dart';
import 'package:snowflake_client/api/exception/internal-server-error.exception.dart';
import 'package:snowflake_client/api/exception/no-internet-connection.exception.dart';
import 'package:snowflake_client/api/exception/not-found.exception.dart';
import 'package:snowflake_client/api/exception/unauthrized.exception.dart';

class AppInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioErrorType.badCertificate:
        break;
      case DioErrorType.unknown:
        break;
    }
    return handler.next(err);
  }
}
