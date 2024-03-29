import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snowflake_client/auth/controller/sign-in.controller.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/sign-in.provider.dart';
import 'package:snowflake_client/common/component/custom_small_button.component.dart';
import 'package:snowflake_client/common/container/moving_background.container.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/i18n/strings.g.dart';
import 'package:snowflake_client/title/title.const.dart';
import 'package:snowflake_client/util/asset_loader.util.dart';
import 'package:snowflake_client/util/func.util.dart';
import 'package:tuple/tuple.dart';

class SignInContainer extends ConsumerStatefulWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends ConsumerState<SignInContainer> {
  PackageInfo? _packageInfo;

  StringsEn get t => ref.watch(translationProvider);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async => _packageInfo = await PackageInfo.fromPlatform());
  }

  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (_) {
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            audioCtrl.setBGM('bgm/fjordnosundakaze.mp3');
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
                          t.subTitle,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...<Widget>[
                          ..._authTypes.map(
                            (e) => CustomSmallButtonComponent(
                              AssetLoader('image/icon/auth/${e.name}.svg').image(),
                              callback: signInCtrl(e).signIn,
                            ),
                          ),
                        ].superJoin(SizedBox(width: 20.r)).toList(),
                      ],
                    ),
                    SizedBox(height: 80.r),
                    Text(
                      t.copyright,
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
