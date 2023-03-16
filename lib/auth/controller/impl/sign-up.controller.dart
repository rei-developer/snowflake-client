import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/auth.route.dart';
import 'package:snowflake_client/auth/controller/sign-up.controller.dart';
import 'package:snowflake_client/auth/dto/request/register.request.dto.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/auth/service/sign-up.service.dart';
import 'package:snowflake_client/common/validation/name.validation.dart';
import 'package:snowflake_client/common/validation/number.validation.dart';
import 'package:snowflake_client/title/title.route.dart';
import 'package:snowflake_client/utils/go.util.dart';

class SignUpController extends ISignUpController {
  SignUpController(this.ref, this.context);

  final Ref ref;
  final BuildContext context;

  ISignUpService get _signUpService => ref.read(signUpServiceProvider);

  @override
  Future<void> register(RegisterRequestDto registerDto) async {
    final isValidName = ref.read(nameValidationProvider)(registerDto.name);
    if (!isValidName) {
      throw ArgumentError(
          'Name should be 2 to 6 characters long, and only alphabets or Korean characters are allowed.');
    }
    final isValidSex = ref.read(minMaxValidationProvider)(registerDto.sex, min: 0, max: 1);
    if (!isValidSex) {
      throw ArgumentError('isValidSex Invalid parameter.');
    }
    final isValidNation = ref.read(minMaxValidationProvider)(registerDto.nation, min: 0, max: 19);
    if (!isValidNation) {
      throw ArgumentError('isValidNation Invalid parameter.');
    }
    final signInResultDto = await _signUpService.register(registerDto);
    print(signInResultDto.uid);
    print(signInResultDto.hasUser);
    print(signInResultDto.hasLover);
    if (!signInResultDto.hasUser) {
      throw ArgumentError('signInResultDto Invalid parameter.');
    }
    if (!context.mounted) {
      return;
    }
    await Go(
      context,
      signInResultDto.hasLover ? TitleRoute.TITLE.name : AuthRoute.CREATE_LOVER.name,
    ).replace(registerDto);
  }
}
