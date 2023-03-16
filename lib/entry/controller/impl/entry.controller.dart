import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/provider/sign-in.provider.dart';
import 'package:snowflake_client/auth/service/sign-in.service.dart';
import 'package:snowflake_client/common/component/dialog/confirm.dialog.dart';
import 'package:snowflake_client/common/provider/common.provider.dart';
import 'package:snowflake_client/common/service/system.service.dart';
import 'package:snowflake_client/entry/controller/entry.controller.dart';
import 'package:snowflake_client/utils/go.util.dart';

class EntryController extends IEntryController {
  EntryController(this.ref, this.context)
      : _signInService = ref.read(signInServiceProvider),
        _systemService = ref.read(systemServiceProvider.notifier);

  final Ref ref;
  final BuildContext context;
  final ISignInService _signInService;
  final ISystemService _systemService;

  @override
  Future<void> entry() async {
    if (await _systemService.isConnected) {
      await _entry();
      return;
    }
    if (await showConfirmDialog(
      context,
      title: '연결 불가',
      message: '인터넷 연결이 불량합니다. 네트워크를 확인하십시오.',
      cancelButtonLabel: '종료',
      confirmButtonLabel: '재연결',
    )) {
      await Future.delayed(const Duration(seconds: 5));
      await entry();
      return;
    }
    await _systemService.shutdown(true);
  }

  Future<void> _entry() async {
    final routeName = await _signInService.signIn(true);
    if (!context.mounted) {
      return;
    }
    await Go(context, routeName).replace();
  }
}
