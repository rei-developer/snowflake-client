import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snowflake_client/auth/component/sign-in/sign-in_button.component.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/sign-in.provider.dart';
import 'package:snowflake_client/common/container/moving_background.container.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/network/tcp_connection.dart';
import 'package:snowflake_client/title/title.const.dart';
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
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        final connection = TcpConnection(
          Environment.instance.serviceServer.host,
          Environment.instance.serviceServer.port,
        );
        await connection.connect();
        _connection = connection;
        _packageInfo = await PackageInfo.fromPlatform();
      },
    );
  }

  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (_) {
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            audioCtrl.playBGM('audio/bgm/fjordnosundakaze.mp3');
            return audioCtrl.stopBGM;
          }, [audioCtrl]);
          ISignInController signInCtrl(e) => ref.read(signInControllerProvider(Tuple2(context, e)));
          return WallpaperCarouselContainer(
            TitleBackgroundImage.values.map((e) => e.path).toList(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _packageInfo?.version ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'Snowflake',
                          colors: [Colors.blue, Colors.black, Colors.white],
                          textStyle: TextStyle(
                            fontSize: 60.r,
                            fontFamily: 'AnastasiaScript',
                          ),
                        ),
                      ],
                      repeatForever: true,
                      isRepeatingAnimation: true,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.amber,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...<Widget>[
                              ..._authTypes.map(
                                (e) => SignInButtonComponent(e, callback: signInCtrl(e).signIn),
                              ),
                            ].superJoin(SizedBox(width: 20.r)).toList(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 80.r),
                    Text(
                      'ⓒ Yukki Studio 2023 - All rights reserved.',
                      style: TextStyle(color: Colors.black, fontSize: 14.r),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

  List<AuthType> get _authTypes => [AuthType.APPLE, AuthType.GOOGLE, AuthType.FACEBOOK];
}
