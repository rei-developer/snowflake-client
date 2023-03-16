import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
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
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            audioCtrl.playBGM('audio/bgm/fjordnosundakaze.mp3');
            return audioCtrl.stopBGM;
          }, [audioCtrl]);
          final signUpCtrl = ref.read(signUpControllerProvider(context));
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
                        autofocus: true,
                        onChanged: _setName,
                      ),
                      SizedBox(height: 20.r),
                      MaterialButton(
                        color: Colors.pinkAccent,
                        child: const Text('Create new account'),
                        onPressed: () async {
                          final toastCtrl = ref.read(toastControllerProvider);
                          try {
                            await signUpCtrl.register(
                              RegisterRequestDto(
                                name,
                                0,
                                0,
                              ),
                            );
                          } on ArgumentError catch (err) {
                            print('SignUpContainer build error => $err');
                            _setName();
                            await toastCtrl(err.message);
                          } on DioError catch (err) {
                            await toastCtrl(err.response?.data.toString() ?? '');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

  void _setName([String text = '']) => setState(() => name = text);
}
