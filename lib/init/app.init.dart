import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/app/main.app.dart';
import 'package:snowflake_client/firebase_options.dart';
import 'package:snowflake_client/init/hive.init.dart';

class AppInit {
  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await HiveInit.run();
    runApp(
      const ProviderScope(child: MainApp()),
    );
  }
}
