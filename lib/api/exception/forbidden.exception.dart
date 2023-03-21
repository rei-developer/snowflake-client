import 'package:dio/dio.dart';

class ForbiddenException extends DioError {
  ForbiddenException(this.r) : super(requestOptions: r.requestOptions);

  final DioError r;

  @override
  String toString() => r.response?.data['message'];
}
