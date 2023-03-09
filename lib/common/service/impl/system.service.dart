import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:snowflake_client/common/service/system.service.dart';

class SystemService extends ISystemService {
  SystemService() : super(DateTime.now());

  @override
  void update([int seconds = 3]) => state = DateTime.now().add(Duration(seconds: seconds));

  @override
  Future<void> shutdown([bool isForce = false, int seconds = 3]) async {
    if (isRun || isForce) {
      await SystemNavigator.pop();
      exit(0);
    }
    update(seconds);
    // Fluttertoast.showToast(msg: t.commonMessage.shutdown);
  }

  @override
  bool get isRun => state.difference(DateTime.now()).inSeconds > 0;

  @override
  Future<bool> get isConnected async =>
      await Connectivity().checkConnectivity() != ConnectivityResult.none;
}
