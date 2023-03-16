import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/controller/impl/sign-up.controller.dart';
import 'package:snowflake_client/auth/controller/sign-up.controller.dart';
import 'package:snowflake_client/auth/service/impl/sign-up.service.dart';
import 'package:snowflake_client/auth/service/sign-up.service.dart';

final signUpControllerProvider = Provider.family<ISignUpController, BuildContext>(
  (ref, context) => SignUpController(ref, context),
);

final signUpServiceProvider = Provider.autoDispose<ISignUpService>((ref) => SignUpService(ref));
