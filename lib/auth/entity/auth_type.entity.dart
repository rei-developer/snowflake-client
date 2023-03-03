import 'package:hive/hive.dart';

part 'auth_type.entity.g.dart';

@HiveType(typeId: 3)
enum AuthType {
  @HiveField(0)
  MTIX('local'),
  @HiveField(1)
  GOOGLE('google'),
  @HiveField(2)
  APPLE('apple'),
  @HiveField(3)
  FACEBOOK('facebook'),
  @HiveField(4)
  TWITTER('twitter');

  const AuthType(this.name);

  final String name;
}
