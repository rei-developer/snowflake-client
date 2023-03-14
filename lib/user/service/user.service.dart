import 'package:snowflake_client/user/dto/user.dto.dart';

abstract class IUserService {
  Future<bool> setUser(UserDto userDto);
}
