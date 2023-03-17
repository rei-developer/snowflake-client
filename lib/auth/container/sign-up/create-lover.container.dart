import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/common/component/custom_radio.component.dart';
import 'package:snowflake_client/common/component/custom_text_field.component.dart';
import 'package:snowflake_client/common/component/dropdown_menu.component.dart';
import 'package:snowflake_client/common/const/options.const.dart';
import 'package:snowflake_client/common/container/moving_background.container.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/title/title.const.dart';

class CreateLoverContainer extends ConsumerStatefulWidget {
  const CreateLoverContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateLoverContainer> createState() => _CreateLoverContainerState();
}

class _CreateLoverContainerState extends ConsumerState<CreateLoverContainer> {
  String _name = '';
  int _race = 1;
  int _sex = 2;
  int _age = 18;
  String _hairColor = 'yellow hair';
  String _hairShape = 'long_hair';
  String _hairStyle = 'ponytail';
  String _face = '';
  String _eyes = 'red_eyes';
  String _nose = '';
  String _mouth = '';
  String _ears = '';
  String _body = 'slender';
  String _breast = 'medium_breasts';

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (_) {
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            audioCtrl.playBGM('audio/bgm/fjordnosundakaze.mp3');
            return audioCtrl.stopBGM;
          }, [audioCtrl]);
          final signUpCtrl = ref.read(signUpControllerProvider(context));
          final toastCtrl = ref.read(toastControllerProvider);
          return WallpaperCarouselContainer(
            TitleBackgroundImage.values.map((e) => e.path).toList(),
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 1.8,
                ),
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
                            hintText: '소녀의 이름을 정하세요. (한글 2-6글자)',
                            autofocus: true,
                            onChanged: _setName,
                          ),
                          SizedBox(height: 10.r),
                          CustomRadioComponent(raceOptions,
                              defaultValue: _race, onChanged: _setRace),
                          SizedBox(height: 10.r),
                          CustomRadioComponent(sexOptions,
                              defaultValue: _sex, onChanged: _setSex),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {for (final item in hairOptions['color']!) item: '$item 선택'},
                            defaultValue: _hairColor,
                            onChanged: _setHairColor,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {for (final item in hairOptions['shape']!) item: '$item 선택'},
                            defaultValue: _hairShape,
                            onChanged: _setHairShape,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {for (final item in hairOptions['style']!) item: '$item 선택'},
                            defaultValue: _hairStyle,
                            onChanged: _setHairStyle,
                          ),
                          SizedBox(height: 10.r),
                          MaterialButton(
                            color: Colors.pinkAccent,
                            disabledColor: Colors.grey,
                            onPressed: _name.isNotEmpty
                                ? () async {
                                    try {
                                      await signUpCtrl
                                          .register(RegisterRequestDto(_name, _sex, _race));
                                    } on ArgumentError catch (err) {
                                      print('SignUpContainer build error => $err');
                                      _setName();
                                      await toastCtrl(err.message);
                                    } on DioError catch (err) {
                                      await toastCtrl(err.response?.data.toString() ?? '');
                                    }
                                  }
                                : null,
                            child: Text('${_name.isEmpty ? '소녀' : _name} 만나러 가기'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(height: 80.r),
              ],
            ),
          );
        },
      );

  void _setName([String value = '']) => setState(() => _name = value);

  void _setRace([int value = 1]) => setState(() => _race = value);

  void _setSex([int value = 2]) => setState(() => _sex = value);

  void _setHairColor([String value = 'yellow hair']) => setState(() => _hairColor = value);

  void _setHairShape([String value = 'long_hair']) => setState(() => _hairShape = value);

  void _setHairStyle([String value = 'ponytail']) => setState(() => _hairStyle = value);
}
