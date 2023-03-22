import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/common/component/custom_radio.component.dart';
import 'package:snowflake_client/common/component/custom_text_field.component.dart';
import 'package:snowflake_client/common/const/options.const.dart';
import 'package:snowflake_client/common/container/moving_background.container.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/i18n/strings.g.dart';
import 'package:snowflake_client/title/title.const.dart';

class SignUpContainer extends ConsumerStatefulWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends ConsumerState<SignUpContainer> {
  String _name = '';
  int _sex = 1;
  int _nation = 1;

  StringsEn get t => ref.watch(translationProvider);

  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (_) {
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            audioCtrl.setBGM('bgm/fjordnosundakaze.mp3');
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
                      CustomTextField(
                        hintText: t.common.form.name.hintText,
                        autofocus: true,
                        onChanged: _setName,
                      ),
                      SizedBox(height: 10.r),
                      CustomRadioComponent(sexOptions, defaultValue: _sex, onChanged: _setSex),
                      SizedBox(height: 10.r),
                      MaterialButton(
                        color: const Color(0xFFffb7c5),
                        disabledColor: Colors.grey,
                        onPressed: _name.isNotEmpty
                            ? () => signUpCtrl.register(RegisterRequestDto(_name, _sex, _nation))
                            : null,
                        child: Text(t.signUp.register.form.confirm),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

  void _setName([String value = '']) => setState(() => _name = value);

  void _setSex([int value = 1]) => setState(() => _sex = value);

  void _setNation([int value = 1]) => setState(() => _nation = value);
}
