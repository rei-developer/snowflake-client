import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/entry/entry.route.dart';
import 'package:snowflake_client/route_manager.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  static const applicationLifecycleChannel = BasicMessageChannel(
    'applicationLifeCycle',
    StringCodec(),
  );
  static const kApplicationWillTerminate = 'applicationWillTerminate';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    applicationLifecycleChannel.setMessageHandler(
      (message) async {
        switch (message) {
          case kApplicationWillTerminate:
            break;
          default:
            break;
        }
        return message ?? '';
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          title: 'App',
          theme: ThemeData(
            primaryColor: Colors.black,
            textTheme: Typography.englishLike2018.apply(
              bodyColor: Colors.black,
              fontSizeFactor: 1.sp,
            ),
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              color: Colors.black,
              elevation: 0,
              centerTitle: false,
            ),
            buttonTheme: const ButtonThemeData(
              // buttonColor: PRIMARY_COLOR,
              textTheme: ButtonTextTheme.primary,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 0),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateInitialRoutes: (_) => RouteManager.onGenerateInitialRoutes(
            CommonRoute.ENTRY.name,
          ),
          onGenerateRoute: RouteManager.onGenerateRoute,
        ),
      );
}
