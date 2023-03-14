import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/user/dto/user.dto.dart';
import 'package:snowflake_client/user/service/user.service.dart';

class UserService extends IUserService {
  UserService(this.ref);

  final Ref ref;

  @override
  Future<bool> setUser(UserDto userDto) async => true;
}
