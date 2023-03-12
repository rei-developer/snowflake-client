import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/sign-in.provider.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:tuple/tuple.dart';

class SignUpContainer extends ConsumerStatefulWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends ConsumerState<SignUpContainer> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await ref.read(audioControllerProvider.notifier).playBGM('audio/bgm/fjordnosundakaze.mp3');
    });
  }

  @override
  Widget build(BuildContext context) {
    ISignInController authCtrl(authType) =>
        ref.read(signInControllerProvider(Tuple2(context, authType)));
    return Text("heelo!");
  }

  List<AuthType> get _authTypes => [AuthType.APPLE, AuthType.GOOGLE, AuthType.FACEBOOK];
}
