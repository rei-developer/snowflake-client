import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/app/main.app.dart';
import 'package:snowflake_client/init/hive.init.dart';

class AppInit {
  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    await HiveInit.run();
    runApp(
      const ProviderScope(child: MainApp()),
    );
  }
}
