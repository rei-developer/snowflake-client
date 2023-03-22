import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/auth/dto/request/generate_lover.request.dto.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/common/component/content_box.component.dart';
import 'package:snowflake_client/common/component/custom_radio.component.dart';
import 'package:snowflake_client/common/component/custom_small_button.component.dart';
import 'package:snowflake_client/common/component/custom_text_field.component.dart';
import 'package:snowflake_client/common/component/dropdown_menu.component.dart';
import 'package:snowflake_client/common/const/options.const.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/i18n/strings.g.dart';
import 'package:snowflake_client/network/const/service-server/request_packet.const.dart';
import 'package:snowflake_client/network/controller/tcp_connection.controller.dart';
import 'package:snowflake_client/network/provider/network.provider.dart';
import 'package:snowflake_client/util/func.util.dart';
import 'package:snowflake_client/util/save_image_to_gallery.util.dart';

class GenerateLoverContainer extends ConsumerStatefulWidget {
  const GenerateLoverContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<GenerateLoverContainer> createState() => _GenerateLoverContainerState();
}

class _GenerateLoverContainerState extends ConsumerState<GenerateLoverContainer> {
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
  bool _isHide = false;

  final TextEditingController controller = TextEditingController();

  ITcpConnectionController get _serviceServer => ref.watch(serviceServerProvider.notifier);

  StringsEn get t => ref.watch(translationProvider);

  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (_) {
          final audioCtrl = ref.read(audioControllerProvider.notifier);
          useEffect(() {
            audioCtrl.setBGM('bgm/trance2.mp3');
            _generateLover();
            return audioCtrl.stopBGM;
          }, [audioCtrl]);
          final signUpStateRepo = ref.watch(signUpStateRepositoryProvider);
          return GestureDetector(
            onTap: _isHide ? _toggleHide : null,
            child: Stack(
              children: [
                if (signUpStateRepo.generatedLoverHash.isEmpty)
                  _renderBlankScreen()
                else
                  _renderGeneratedLoverImage(signUpStateRepo.generatedLoverHash),
                if (!_isHide) ...[
                  _renderName(),
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(height: MediaQuery.of(context).size.height * 1 / 1.5),
                      _renderFeatures(signUpStateRepo.generatedLoverHash),
                      ContentBoxComponent(
                        Column(
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
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setHairShape(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                DropdownMenuComponent(
                                  {
                                    for (final item in hairOptions['style']!)
                                      item: t['common.options.hair.style.$item']
                                  },
                                  defaultValue: _hairStyle,
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setHairStyle(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                DropdownMenuComponent(
                                  {
                                    for (final item in faceOptions)
                                      item: t['common.options.face.$item']
                                  },
                                  hintText: t.common.form.face.hintText,
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setFace(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                DropdownMenuComponent(
                                  {
                                    for (final item in eyesOptions)
                                      item: t['common.options.eyes.$item']
                                  },
                                  defaultValue: _eyes,
                                  hintText: t.common.form.eyes.hintText,
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setEyes(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                DropdownMenuComponent(
                                  {
                                    for (final item in noseOptions)
                                      item: t['common.options.nose.$item']
                                  },
                                  hintText: t.common.form.nose.hintText,
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setNose(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                DropdownMenuComponent(
                                  {
                                    for (final item in mouthOptions)
                                      item: t['common.options.mouth.$item']
                                  },
                                  hintText: t.common.form.mouth.hintText,
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setMouth(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                DropdownMenuComponent(
                                  {
                                    for (final item in bodyOptions)
                                      item: t['common.options.body.$item']
                                  },
                                  defaultValue: _body,
                                  hintText: t.common.form.body.hintText,
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setBody(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                DropdownMenuComponent(
                                  {
                                    for (final item in breastOptions)
                                      item: t['common.options.breast.$item']
                                  },
                                  defaultValue: _breast,
                                  hintText: t.common.form.breast.hintText,
                                  onChanged: (value) => _setValueAndGenerateLover(
                                    () => _setBreast(value),
                                  ),
                                ),
                                SizedBox(height: 10.r),

                                MaterialButton(
                                  color: const Color(0xFFffb7c5),
                                  disabledColor: Colors.grey,
                                  onPressed: _name.isNotEmpty ? () {} : null,
                                  child: Text(
                                    t.signUp.generateLover.form.confirm(
                                      name: _name.isEmpty
                                          ? t.signUp.generateLover.alias.defaultName
                                          : _name,
                                    ),
                                  ),
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
              ],
            ),
          );
        },
      );

  Widget _renderBlankScreen() => Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
      );

  Widget _renderGeneratedLoverImage(String hash) => CachedNetworkImage(
        imageUrl: _getGeneratedLoverImageUrl(hash),
        placeholder: (context, url) => Container(color: const Color(0xFFffb7c5)),
        errorWidget: (_, __, ___) => Container(color: const Color(0xFFffb7c5)),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );

  Widget _renderName() => Positioned(
        top: 80.r,
        right: 10.r,
        child: Text(
          _name.isEmpty ? t.signUp.generateLover.title : _name,
          style: TextStyle(
            color: const Color(0xFFffb7c5),
            fontSize: 32.r,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _renderFeatures(String hash) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomSmallButtonComponent(
              const Icon(Icons.visibility, color: Colors.white),
              callback: _toggleHide,
            ),
            if (hash.isNotEmpty)
              CustomSmallButtonComponent(
                const Icon(Icons.camera_alt, color: Colors.white),
                callback: () => saveImageToGallery(
                  _getGeneratedLoverImageUrl(hash),
                ),
              ),
          ].superJoin(SizedBox(width: 10.r)).toList(),
        ),
      );

  String _getGeneratedLoverImageUrl(String hash) =>
      'https://f002.backblazeb2.com/file/yukki-studio/snowflake/generated-ai-image/$hash.webp';

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

  void _toggleHide() => setState(() => _isHide = !_isHide);

  Future<void> _setValueAndGenerateLover(VoidCallback callback) async {
    callback.call();
    await _generateLover();
  }

  Future<void> _generateLover() => _serviceServer.sendMessage(
        ServiceServerRequestPacket.generateLover.id,
        GenerateLoverRequestDto(
          _name,
          _race,
          _sex,
          _age,
          _hairColor,
          _hairShape,
          _hairStyle,
          _face,
          _eyes,
          _nose,
          _mouth,
          _ears,
          _body,
          _breast,
        ).toBinary(),
      );
}
