import 'package:snowflake_client/user/model/user.model.dart';

class UserDto {
  UserDto(this.user);

  UserDto.fromJson(json)
      : user = UserModel.initial(
          id: (json['user']['id'] ?? 0),
          uid: (json['user']['uid'] ?? ''),
          name: (json['user']['name'] ?? ''),
          sex: (json['user']['sex'] ?? 0),
        );

  final UserModel user;
}
