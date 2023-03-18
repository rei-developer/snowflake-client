import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/controller/impl/sign-up.controller.dart';
import 'package:snowflake_client/auth/controller/sign-up.controller.dart';
import 'package:snowflake_client/auth/repository/impl/sign-up-state.repository.dart';
import 'package:snowflake_client/auth/repository/sign-up.repository.dart';
import 'package:snowflake_client/auth/service/impl/sign-up.service.dart';
import 'package:snowflake_client/auth/service/sign-up.service.dart';

final signUpControllerProvider = Provider.family<ISignUpController, BuildContext>(
  (ref, context) => SignUpController(ref, context),
);

final signUpStateRepositoryProvider = StateProvider<ISignUpRepository>(
  (ref) => SignUpStateRepository(),
);

final signUpServiceProvider = Provider.autoDispose<ISignUpService>((ref) => SignUpService(ref));
