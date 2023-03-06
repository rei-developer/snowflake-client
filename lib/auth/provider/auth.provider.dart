import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/auth/controller/auth.controller.dart';
import 'package:snowflake_client/auth/controller/impl/auth.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/model/auth.model.dart';
import 'package:snowflake_client/auth/repository/auth-local.repository.dart';
import 'package:snowflake_client/auth/repository/impl/auth-local.repository.dart';
import 'package:snowflake_client/auth/service/auth.service.dart';
import 'package:snowflake_client/auth/service/impl/auth-apple.service.dart';
import 'package:snowflake_client/auth/service/impl/auth-google.service.dart';

final authControllerProvider = StateNotifierProvider.family<IAuthController, AuthModel, AuthType?>(
  (ref, authType) => AuthController(ref, authType),
);

final authLocalRepositoryProvider = StateNotifierProvider<IAuthLocalRepository, Box>(
  (_) => AuthLocalRepository(),
);

final authServiceProvider = Provider.family.autoDispose<IAuthService, AuthType?>(
  (ref, authType) {
    switch (authType) {
      case AuthType.APPLE:
        return AuthAppleService(ref);
      case AuthType.GOOGLE:
        return AuthGoogleService(ref);
      default:
        // TODO: custom auth service
        return AuthGoogleService(ref);
    }
  },
);
