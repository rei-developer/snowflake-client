import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/auth-rest.repository.dart';
import 'package:snowflake_client/auth/repository/impl/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/impl/auth-rest.repository.dart';
import 'package:snowflake_client/auth/service/auth-custom.service.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';
import 'package:snowflake_client/auth/service/impl/auth-apple.service.dart';
import 'package:snowflake_client/auth/service/impl/auth-custom.service.dart';
import 'package:snowflake_client/auth/service/impl/auth-facebook.service.dart';
import 'package:snowflake_client/auth/service/impl/auth-google.service.dart';

final authLocalRepositoryProvider = StateNotifierProvider<IAuthLocalRepository, Box>(
  (_) => AuthLocalRepository(),
);

final authRestRepositoryProvider = Provider<IAuthRestRepository>(
  (ref) => AuthRestRepository(ref.watch(authLocalRepositoryProvider.notifier)),
);

final authServiceProvider = Provider.family.autoDispose<IAuthService, AuthType?>(
  (ref, authType) {
    switch (authType) {
      case AuthType.APPLE:
        return AuthAppleService(ref);
      case AuthType.GOOGLE:
        return AuthGoogleService(ref);
      default:
        return AuthFacebookService(ref);
    }
  },
);

final authCustomServiceProvider = Provider.autoDispose<IAuthCustomService>(
  (ref) => AuthCustomService(ref),
);
