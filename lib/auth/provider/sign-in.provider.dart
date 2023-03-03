import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/controller/impl/sign-in.controller.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:tuple/tuple.dart';

final signInControllerProvider = StateProvider.family<ISignInController, Tuple2<BuildContext, AuthType?>>(
  (ref, args) => SignInController(ref, args.item1, args.item2),
);
