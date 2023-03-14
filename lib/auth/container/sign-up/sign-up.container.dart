import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/auth/provider/auth.provider.dart';
import 'package:snowflake_client/common/container/moving_background.container.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/title/title.const.dart';

class SignUpContainer extends ConsumerStatefulWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends ConsumerState<SignUpContainer> {
  String name = '';

  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (_) {
          final authCtrl = ref.read(authControllerProvider(AuthType.LOCAL));
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            audioCtrl.playBGM('audio/bgm/fjordnosundakaze.mp3');
            return audioCtrl.stopBGM;
          }, [audioCtrl]);
          return WallpaperCarouselContainer(
            TitleBackgroundImage.values.map((e) => e.path).toList(),
            Container(
              padding: EdgeInsets.all(20.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: '캐릭터 이름을 입력하세요. (한글 2-6글자)',
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.r),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onChanged: (text) => setState(() => name = text),
                      ),
                      SizedBox(height: 20.r),
                      MaterialButton(
                        color: Colors.pinkAccent,
                        child: const Text('Create new account'),
                        onPressed: () => authCtrl.register(name),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
}
