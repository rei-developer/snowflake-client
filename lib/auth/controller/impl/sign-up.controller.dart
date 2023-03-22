import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/api/exception/forbidden.exception.dart';
import 'package:snowflake_client/auth/auth.route.dart';
import 'package:snowflake_client/auth/controller/sign-up.controller.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/auth/service/sign-up.service.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/common/validation/name.validation.dart';
import 'package:snowflake_client/common/validation/number.validation.dart';
import 'package:snowflake_client/i18n/strings.g.dart';
import 'package:snowflake_client/title/title.route.dart';
import 'package:snowflake_client/util/go.util.dart';

class SignUpController extends ISignUpController {
  SignUpController(this.ref, this.context);

  final Ref ref;
  final BuildContext context;

  dynamic get _toastCtrl => ref.read(toastControllerProvider);

  ISignUpService get _signUpService => ref.read(signUpServiceProvider);

  StringsEn get t => ref.watch(translationProvider);

  @override
  Future<void> register(RegisterRequestDto registerDto) async {
    try {
      final isValidName = ref.read(nameValidationProvider)(registerDto.name);
      if (!isValidName) {
        throw ArgumentError(t.common.form.name.errorMessage.invalidValue);
      }
      final isValidSex = ref.read(minMaxValidationProvider)(registerDto.sex, min: 1, max: 2);
      if (!isValidSex) {
        throw ArgumentError('isValidSex Invalid parameter.');
      }
      final isValidNation = ref.read(minMaxValidationProvider)(registerDto.nation, min: 1, max: 20);
      if (!isValidNation) {
        throw ArgumentError('isValidNation Invalid parameter.');
      }
      final signInResultDto = await _signUpService.register(registerDto);
      if (!signInResultDto.hasUser) {
        throw ArgumentError('signInResultDto Invalid parameter.');
      }
      if (!context.mounted) {
        return;
      }
      await Go(
        context,
        signInResultDto.hasLover ? TitleRoute.TITLE.name : AuthRoute.GENERATE_LOVER.name,
      ).replace(registerDto);
    } on ArgumentError catch (err) {
      await _toastCtrl(err.message);
    } on ForbiddenException catch (err) {
      await _toastCtrl(t['api.errorMessage.$err']);
    }
  }

  @override
  void setLock(bool lock) => _signUpService.setLock(lock);
}
