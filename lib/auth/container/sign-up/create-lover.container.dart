import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/common/component/content_box.component.dart';
import 'package:snowflake_client/common/component/custom_radio.component.dart';
import 'package:snowflake_client/common/component/custom_text_field.component.dart';
import 'package:snowflake_client/common/component/dropdown_menu.component.dart';
import 'package:snowflake_client/common/const/options.const.dart';
import 'package:snowflake_client/common/container/moving_background.container.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/i18n/strings.g.dart';
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
  String _hairColor = 'Blonde_hair';
  String _hairShape = 'medium_hair';
  String _hairStyle = 'ponytail';
  String _face = '';
  String _eyes = 'red_eyes';
  String _nose = '';
  String _mouth = '';
  String _ears = '';
  String _body = 'slender';
  String _breast = 'medium_breasts';

  final TextEditingController controller = TextEditingController();

  StringsEn get t => ref.watch(translationProvider);

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
                ContentBoxComponent(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            hintText: t.signUp.createLover.form.name.hintText,
                            autofocus: true,
                            onChanged: _setName,
                          ),
                          SizedBox(height: 10.r),
                          CustomRadioComponent(
                            Map.from(raceOptions).map(
                              (key, value) => MapEntry(t['common.options.race.$key'], value),
                            ),
                            defaultValue: _race,
                            onChanged: _setRace,
                          ),
                          SizedBox(height: 10.r),
                          CustomRadioComponent(
                            Map.from(sexOptions).map(
                              (key, value) => MapEntry(t['common.options.sex.$key'], value),
                            ),
                            defaultValue: _sex,
                            onChanged: _setSex,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {
                              for (final item in hairOptions['color']!)
                                item: t['common.options.hair.color.$item']
                            },
                            defaultValue: _hairColor,
                            onChanged: _setHairColor,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {
                              for (final item in hairOptions['shape']!)
                                item: t['common.options.hair.shape.$item']
                            },
                            defaultValue: _hairShape,
                            onChanged: _setHairShape,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {
                              for (final item in hairOptions['style']!)
                                item: t['common.options.hair.style.$item']
                            },
                            defaultValue: _hairStyle,
                            onChanged: _setHairStyle,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {for (final item in faceOptions) item: t['common.options.face.$item']},
                            hintText: t.common.form.face.hintText,
                            onChanged: _setFace,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {for (final item in eyesOptions) item: t['common.options.eyes.$item']},
                            defaultValue: _eyes,
                            hintText: t.common.form.eyes.hintText,
                            onChanged: _setEyes,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {for (final item in noseOptions) item: t['common.options.nose.$item']},
                            hintText: t.common.form.nose.hintText,
                            onChanged: _setNose,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {
                              for (final item in mouthOptions) item: t['common.options.mouth.$item']
                            },
                            hintText: t.common.form.mouth.hintText,
                            onChanged: _setMouth,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {for (final item in bodyOptions) item: t['common.options.body.$item']},
                            defaultValue: _body,
                            hintText: t.common.form.body.hintText,
                            onChanged: _setBody,
                          ),
                          SizedBox(height: 10.r),
                          DropdownMenuComponent(
                            {
                              for (final item in breastOptions)
                                item: t['common.options.breast.$item']
                            },
                            defaultValue: _breast,
                            hintText: t.common.form.breast.hintText,
                            onChanged: _setBreast,
                          ),
                          SizedBox(height: 10.r),
                          MaterialButton(
                            color: Colors.pinkAccent,
                            disabledColor: Colors.grey,
                            onPressed: _name.isNotEmpty
                                ? () async {
                                    try {
                                      await signUpCtrl.register(
                                        RegisterRequestDto(
                                          _name,
                                          _sex,
                                          _race,
                                        ),
                                      );
                                    } on ArgumentError catch (err) {
                                      await toastCtrl(err.message);
                                    } on DioError catch (err) {
                                      await toastCtrl(err.response?.data.toString() ?? '');
                                    } catch (err) {
                                      print('SignUpContainer build error => $err');
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

  void _setName(String value) => setState(() => _name = value);

  void _setRace(int value) => setState(() => _race = value);

  void _setSex(int value) => setState(() => _sex = value);

  void _setAge(int value) => setState(() => _age = value);

  void _setHairColor(String value) => setState(() => _hairColor = value);

  void _setHairShape(String value) => setState(() => _hairShape = value);

  void _setHairStyle(String value) => setState(() => _hairStyle = value);

  void _setFace(String value) => setState(() => _face = value);

  void _setEyes(String value) => setState(() => _eyes = value);

  void _setNose(String value) => setState(() => _nose = value);

  void _setMouth(String value) => setState(() => _mouth = value);

  void _setEars(String value) => setState(() => _ears = value);

  void _setBody(String value) => setState(() => _body = value);

  void _setBreast(String value) => setState(() => _breast = value);
}
