import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/component/sign-in/sign-in_button.component.dart';
import 'package:snowflake_client/auth/controller/auth.controller.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/auth/provider/sign-in.provider.dart';
import 'package:snowflake_client/network/tcp_connection.dart';
import 'package:snowflake_client/utils/func.util.dart';
import 'package:snowflake_client/utils/json_to_binary.util.dart';
import 'package:tuple/tuple.dart';

class SignInContainer extends ConsumerStatefulWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends ConsumerState<SignInContainer> {
  TcpConnection? _connection;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final connection = TcpConnection('127.0.0.1', 10004);
      await connection.connect();
      setState(() => _connection = connection);
    });
  }

  @override
  Widget build(BuildContext context) {
    ISignInController authCtrl(authType) =>
        ref.read(signInControllerProvider(Tuple2(context, authType)));
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...<Widget>[
            ..._authTypes.map((e) => SignInButtonComponent(e, callback: authCtrl(e).signIn))
          ].superJoin(SizedBox(height: 10.r)).toList(),
          SizedBox(height: 20.r),
          MaterialButton(
            color: Colors.pink,
            child: const Text('Verify idToken'),
            onPressed: () {
              _connection?.sendMessage(
                0,
                jsonToBinary({
                  'token':
                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIxIn0.LTF9jRPVB8H7K4XJDrjU4sIyZNyevzFLe_H_ZSGk1_s'
                }),
              );
            },
          ),
          SizedBox(height: 20.r),
          MaterialButton(
            color: Colors.blue,
            child: const Text('Send tcp message'),
            onPressed: () {
              _connection?.sendMessage(
                2,
                jsonToBinary({"bye": 23423}),
              );
            },
          ),
        ],
      ),
    );
  }

  List<AuthType> get _authTypes => [AuthType.APPLE, AuthType.GOOGLE, AuthType.FACEBOOK];
}
