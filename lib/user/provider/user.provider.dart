import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/user/service/impl/user.service.dart';
import 'package:snowflake_client/user/service/user.service.dart';

final userServiceProvider = Provider.autoDispose<IUserService>((ref) => UserService(ref));
