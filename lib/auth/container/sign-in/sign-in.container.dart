import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/component/sign-in/sign-in_button.component.dart';
import 'package:snowflake_client/auth/controller/auth.controller.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/provider/sign-in.provider.dart';
import 'package:snowflake_client/utils/func.util.dart';
import 'package:tuple/tuple.dart';

class SignInContainer extends ConsumerStatefulWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends ConsumerState<SignInContainer> {
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...<Widget>[..._authTypes.map((e) => SignInButtonComponent(e, callback: _authCtrl(e).signIn))]
                .superJoin(SizedBox(height: 10.r))
                .toList(),
            SizedBox(height: 20.r),
            MaterialButton(
              color: Colors.lightBlue,
              child: Text('테스트'),
              onPressed: _signInCtrl().goToTitle,
            ),
          ],
        ),
      );

  IAuthController _authCtrl(AuthType authType) => ref.read(authControllerProvider(authType).notifier);

  ISignInController _signInCtrl() => ref.read(signInControllerProvider(Tuple2(context, null)));

  List<AuthType> get _authTypes => [AuthType.GOOGLE];
}