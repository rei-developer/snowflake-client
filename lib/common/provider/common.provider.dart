import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/service/impl/system.service.dart';
import 'package:snowflake_client/common/service/system.service.dart';

final systemServiceProvider = StateNotifierProvider<ISystemService, DateTime>(
  (_) => SystemService(),
);
