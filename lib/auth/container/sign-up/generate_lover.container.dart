import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snowflake_client/auth/controller/sign-up.controller.dart';
import 'package:snowflake_client/auth/dto/request/generate_lover.request.dto.dart';
import 'package:snowflake_client/auth/model/sign-up.model.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/common/component/content_box.component.dart';
import 'package:snowflake_client/common/component/custom_radio.component.dart';
import 'package:snowflake_client/common/component/custom_small_button.component.dart';
import 'package:snowflake_client/common/component/custom_text_field.component.dart';
import 'package:snowflake_client/common/component/dropdown_menu.component.dart';
import 'package:snowflake_client/common/const/options.const.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/i18n/strings.g.dart';
import 'package:snowflake_client/network/const/service-server/request_packet.const.dart';
import 'package:snowflake_client/network/controller/tcp_connection.controller.dart';
import 'package:snowflake_client/network/provider/network.provider.dart';
import 'package:snowflake_client/util/asset_loader.util.dart';
import 'package:snowflake_client/util/func.util.dart';
import 'package:snowflake_client/util/save_image_to_gallery.util.dart';

class GenerateLoverContainer extends ConsumerStatefulWidget {
  const GenerateLoverContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<GenerateLoverContainer> createState() => _GenerateLoverContainerState();
}

class _GenerateLoverContainerState extends ConsumerState<GenerateLoverContainer>
    with TickerProviderStateMixin {
  static const _defaultHairColor = 'Blonde_hair';
  static const _defaultHairShape = 'medium_hair';
  static const _defaultHairStyle = 'ponytail';
  static const _defaultFace = '';
  static const _defaultEyes = 'red_eyes';
  static const _defaultNose = '';
  static const _defaultMouth = '';
  static const _defaultEars = '';
  static const _defaultBody = 'slender';
  static const _defaultBreast = 'medium_breasts';

  String _name = '';
  int _race = 1;
  int _sex = 2;
  int _age = 18;
  String _hairColor = '';
  String _hairShape = '';
  String _hairStyle = '';
  String _face = '';
  String _eyes = '';
  String _nose = '';
  String _mouth = '';
  String _ears = '';
  String _body = '';
  String _breast = '';
  String _binaryCache = '';
  bool _isHide = false;

  final _hairColorKey = GlobalKey<DropdownMenuComponentState>();
  final _hairShapeKey = GlobalKey<DropdownMenuComponentState>();
  final _hairStyleKey = GlobalKey<DropdownMenuComponentState>();
  final _faceKey = GlobalKey<DropdownMenuComponentState>();
  final _eyesKey = GlobalKey<DropdownMenuComponentState>();
  final _noseKey = GlobalKey<DropdownMenuComponentState>();
  final _mouthKey = GlobalKey<DropdownMenuComponentState>();
  final _earsKey = GlobalKey<DropdownMenuComponentState>();
  final _bodyKey = GlobalKey<DropdownMenuComponentState>();
  final _breastKey = GlobalKey<DropdownMenuComponentState>();

  final _nameTextCtrl = TextEditingController();
  late final _loadingCtrl = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..repeat();

  ISignUpController get _signUpCtrl => ref.read(signUpControllerProvider(context));

  ITcpConnectionController get _serviceServer => ref.watch(serviceServerProvider.notifier);

  StringsEn get t => ref.watch(translationProvider);

  @override
  void initState() {
    _hairColor = _defaultHairColor;
    _hairShape = _defaultHairShape;
    _hairStyle = _defaultHairStyle;
    _face = _defaultFace;
    _eyes = _defaultEyes;
    _nose = _defaultNose;
    _mouth = _defaultMouth;
    _ears = _defaultEars;
    _body = _defaultBody;
    _breast = _defaultBreast;
    super.initState();
  }

  @override
  void dispose() {
    _nameTextCtrl.dispose();
    _loadingCtrl.dispose();
    super.dispose();
  }

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
                  SafeArea(
                    bottom: false,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 1.5,
                          child: signUpStateRepo.isLock
                              ? AnimatedBuilder(
                                  animation: _loadingCtrl,
                                  builder: (_, child) => Transform.rotate(
                                    angle: _loadingCtrl.value * 2 * math.pi,
                                    child: child,
                                  ),
                                  child: Transform.scale(
                                    scale: 0.2.r,
                                    child: AssetLoader('image/common/loading.svg').image(),
                                  ),
                                )
                              : null,
                        ),
                        _renderFeatures(signUpStateRepo),
                        ContentBoxComponent(
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
                                key: _hairColorKey,
                                {
                                  for (final item in hairOptions['color']!)
                                    item: t['common.options.hair.color.$item']
                                },
                                defaultValue: _hairColor,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setHairColor(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _hairShapeKey,
                                {
                                  for (final item in hairOptions['shape']!)
                                    item: t['common.options.hair.shape.$item']
                                },
                                defaultValue: _hairShape,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setHairShape(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _hairStyleKey,
                                {
                                  for (final item in hairOptions['style']!)
                                    item: t['common.options.hair.style.$item']
                                },
                                defaultValue: _hairStyle,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setHairStyle(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _faceKey,
                                {
                                  for (final item in faceOptions)
                                    item: t['common.options.face.$item']
                                },
                                hintText: t.common.form.face.hintText,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setFace(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _eyesKey,
                                {
                                  for (final item in eyesOptions)
                                    item: t['common.options.eyes.$item']
                                },
                                hintText: t.common.form.eyes.hintText,
                                defaultValue: _eyes,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setEyes(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _noseKey,
                                {
                                  for (final item in noseOptions)
                                    item: t['common.options.nose.$item']
                                },
                                hintText: t.common.form.nose.hintText,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setNose(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _mouthKey,
                                {
                                  for (final item in mouthOptions)
                                    item: t['common.options.mouth.$item']
                                },
                                hintText: t.common.form.mouth.hintText,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setMouth(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _bodyKey,
                                {
                                  for (final item in bodyOptions)
                                    item: t['common.options.body.$item']
                                },
                                hintText: t.common.form.body.hintText,
                                defaultValue: _body,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setBody(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              DropdownMenuComponent(
                                key: _breastKey,
                                {
                                  for (final item in breastOptions)
                                    item: t['common.options.breast.$item']
                                },
                                defaultValue: _breast,
                                hintText: t.common.form.breast.hintText,
                                isDisabled: signUpStateRepo.isLock,
                                onChanged: (prev, next) => _setValueAndGenerateLover(
                                  signUpStateRepo.isLock,
                                  () => _setBreast(next),
                                ),
                              ),
                              SizedBox(height: 10.r),
                              MaterialButton(
                                color: const Color(0xFFffb7c5),
                                disabledColor: Colors.grey,
                                onPressed: _name.isNotEmpty
                                    ? () {
                                        audioCtrl.setSE('se/confirm.mp3');
                                        Fluttertoast.showToast(
                                          msg: t.common.errorMessage.unimplemented,
                                        );
                                      }
                                    : null,
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
                        ),
                        Container(height: 80.r),
                      ],
                    ),
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

  Widget _renderFeatures(SignUpModel signUpModel) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomSmallButtonComponent(
              Icon(Icons.refresh, color: Colors.white.withOpacity(signUpModel.isLock ? 0.5 : 1)),
              callback: () => _generateRandomOptions(signUpModel.isLock),
            ),
            CustomSmallButtonComponent(
              const Icon(Icons.visibility, color: Colors.white),
              callback: _toggleHide,
            ),
            if (signUpModel.generatedLoverHash.isNotEmpty)
              CustomSmallButtonComponent(
                const Icon(Icons.camera_alt, color: Colors.white),
                callback: () async {
                  final isSuccess = await saveImageToGallery(
                    _getGeneratedLoverImageUrl(signUpModel.generatedLoverHash),
                  );
                  Fluttertoast.showToast(
                    msg: isSuccess
                        ? t.common.infoMessage.download.succeed
                        : t.common.infoMessage.download.failed,
                  );
                },
              ),
          ].superJoin(SizedBox(width: 10.r)).toList(),
        ),
      );

  String _getGeneratedLoverImageUrl(String hash) =>
      '${Environment.instance.config['s3']['generatedAiImage']}$hash.webp';

  void _setName(String value) => setState(() => _name = value);

  void _setRace(int value) => setState(() => _race = value);

  void _setSex(int value) => setState(() => _sex = value);

  void _setAge(int value) => setState(() => _age = value);

  void _setHairColor(String value) {
    setState(() => _hairColor = value);
    _hairColorKey.currentState?.setSelectedItemByValue(value);
  }

  void _setHairShape(String value) {
    setState(() => _hairShape = value);
    _hairShapeKey.currentState?.setSelectedItemByValue(value);
  }

  void _setHairStyle(String value) {
    setState(() => _hairStyle = value);
    _hairStyleKey.currentState?.setSelectedItemByValue(value);
  }

  void _setFace(String value) {
    setState(() => _face = value);
    _faceKey.currentState?.setSelectedItemByValue(value);
  }

  void _setEyes(String value) {
    setState(() => _eyes = value);
    _eyesKey.currentState?.setSelectedItemByValue(value);
  }

  void _setNose(String value) {
    setState(() => _nose = value);
    _noseKey.currentState?.setSelectedItemByValue(value);
  }

  void _setMouth(String value) {
    setState(() => _mouth = value);
    _mouthKey.currentState?.setSelectedItemByValue(value);
  }

  void _setEars(String value) {
    setState(() => _ears = value);
    _earsKey.currentState?.setSelectedItemByValue(value);
  }

  void _setBody(String value) {
    setState(() => _body = value);
    _bodyKey.currentState?.setSelectedItemByValue(value);
  }

  void _setBreast(String value) {
    setState(() => _breast = value);
    _breastKey.currentState?.setSelectedItemByValue(value);
  }

  void _setBinaryCache(String value) => setState(() => _binaryCache = value);

  void _generateRandomOptions(bool isLock) => _setValueAndGenerateLover(isLock, () async {
        _setHairColor(_getRandomOptions(hairOptions['color']!));
        _setHairShape(_getRandomOptions(hairOptions['shape']!));
        _setHairStyle(_getRandomOptions(hairOptions['style']!));
        _setFace(_getRandomOptions(faceOptions));
        _setEyes(_getRandomOptions(eyesOptions));
        _setNose(_getRandomOptions(noseOptions));
        _setMouth(_getRandomOptions(mouthOptions));
        _setBody(_getRandomOptions(bodyOptions));
        _setBreast(_getRandomOptions(breastOptions));
      });

  String _getRandomOptions(List<String> options) => options[math.Random().nextInt(options.length)];

  void _toggleHide() => setState(() => _isHide = !_isHide);

  Future<void> _setValueAndGenerateLover(bool isLock, VoidCallback callback) async {
    if (isLock) {
      Fluttertoast.showToast(msg: t.signUp.generateLover.loadingMessage);
      return;
    }
    _signUpCtrl.setLock(true);
    callback.call();
    await _generateLover();
  }

  Future<void> _generateLover() async {
    final binary = GenerateLoverRequestDto(
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
    ).toBinary();
    if (binary.toString() == _binaryCache) {
      _signUpCtrl.setLock(false);
      return;
    }
    await _serviceServer.sendMessage(ServiceServerRequestPacket.generateLover.id, binary);
    _setBinaryCache(binary.toString());
  }
}
