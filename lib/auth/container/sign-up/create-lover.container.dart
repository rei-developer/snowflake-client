import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/auth/repository/sign-up.repository.dart';
import 'package:snowflake_client/common/component/content_box.component.dart';
import 'package:snowflake_client/common/component/custom_radio.component.dart';
import 'package:snowflake_client/common/component/custom_text_field.component.dart';
import 'package:snowflake_client/common/component/dropdown_menu.component.dart';
import 'package:snowflake_client/common/const/options.const.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/i18n/strings.g.dart';
import 'package:snowflake_client/network/controller/network.controller.dart';
import 'package:snowflake_client/network/provider/network.provider.dart';
import 'package:snowflake_client/utils/json_to_binary.util.dart';

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

  ISignUpRepository get _signUpStateRepo => ref.watch(signUpStateRepositoryProvider);

  ITcpConnectionController get _serviceServer => ref.watch(serviceServerProvider.notifier);

  StringsEn get t => ref.watch(translationProvider);

  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (_) {
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            _generateLover();
            audioCtrl.playBGM('audio/bgm/fjordnosundakaze.mp3');
            return audioCtrl.stopBGM;
          }, [audioCtrl]);
          final toastCtrl = ref.read(toastControllerProvider);
          return Stack(
            children: [
              if (_signUpStateRepo.drawFirstLoverHash != null)
                CachedNetworkImage(
                  imageUrl: _signUpStateRepo.drawFirstLoverHash!,
                  placeholder: (context, url) => Container(color: Colors.black),
                  errorWidget: (_, __, ___) => Container(color: Colors.black),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              _renderName(),
              ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(height: MediaQuery.of(context).size.height * 1 / 1.5),
                  ContentBoxComponent(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' >> ${_signUpStateRepo.drawFirstLoverHash}'),
                            CustomTextField(
                              hintText: t.common.form.name.hintText,
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
                            // CustomRadioComponent(
                            //   Map.from(sexOptions).map(
                            //     (key, value) => MapEntry(t['common.options.sex.$key'], value),
                            //   ),
                            //   defaultValue: _sex,
                            //   onChanged: _setSex,
                            // ),
                            // SizedBox(height: 10.r),
                            DropdownMenuComponent(
                              {
                                for (final item in hairOptions['color']!)
                                  item: t['common.options.hair.color.$item']
                              },
                              defaultValue: _hairColor,
                              onChanged: (value) => _setValueAndGenerateLover(
                                () => _setHairColor(value),
                              ),
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
                              {
                                for (final item in faceOptions) item: t['common.options.face.$item']
                              },
                              hintText: t.common.form.face.hintText,
                              onChanged: _setFace,
                            ),
                            SizedBox(height: 10.r),
                            DropdownMenuComponent(
                              {
                                for (final item in eyesOptions) item: t['common.options.eyes.$item']
                              },
                              defaultValue: _eyes,
                              hintText: t.common.form.eyes.hintText,
                              onChanged: _setEyes,
                            ),
                            SizedBox(height: 10.r),
                            DropdownMenuComponent(
                              {
                                for (final item in noseOptions) item: t['common.options.nose.$item']
                              },
                              hintText: t.common.form.nose.hintText,
                              onChanged: _setNose,
                            ),
                            SizedBox(height: 10.r),
                            DropdownMenuComponent(
                              {
                                for (final item in mouthOptions)
                                  item: t['common.options.mouth.$item']
                              },
                              hintText: t.common.form.mouth.hintText,
                              onChanged: _setMouth,
                            ),
                            SizedBox(height: 10.r),
                            DropdownMenuComponent(
                              {
                                for (final item in bodyOptions) item: t['common.options.body.$item']
                              },
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
                              onPressed: _name.isNotEmpty ? () {} : null,
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
            ],
          );
        },
      );

  Widget _renderName() => Positioned(
        top: 80.r,
        right: 10.r,
        child: Text(
          _name.isEmpty ? t.signUp.createLover.title : _name,
          style: TextStyle(
            color: const Color(0xFFffb7c5),
            fontSize: 32.r,
            fontWeight: FontWeight.w600,
          ),
        ),
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

  Future<void> _setValueAndGenerateLover(VoidCallback callback) async {
    callback.call();
    await _generateLover();
  }

  Future<void> _generateLover() => _serviceServer.sendMessage(
        1,
        jsonToBinary({
          'name': _name,
          'race': _race,
          'sex': _sex,
          'age': _age,
          'hairColor': _hairColor,
          'hairShape': _hairShape,
          'hairStyle': _hairStyle,
          'face': _face,
          'eyes': _eyes,
          'nose': _nose,
          'mouth': _mouth,
          'ears': _ears,
          'body': _body,
          'breast': _breast,
        }),
      );
}
