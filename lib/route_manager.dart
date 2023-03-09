import 'package:flutter/material.dart';
import 'package:snowflake_client/auth/auth.route.dart';
import 'package:snowflake_client/dictionary/dictionary.route.dart';
import 'package:snowflake_client/entry/entry.route.dart';
import 'package:snowflake_client/title/title.route.dart';

class RouteManager {
  RouteManager();

  static List<MaterialPageRoute> onGenerateInitialRoutes([String? routeName = '/']) =>
      [MaterialPageRoute(builder: (context) => _getRoutes[routeName]!(context))];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, __, ___) => _getRoutes[settings.name]!(context),
        transitionDuration: const Duration(),
      );

  static Map<String, WidgetBuilder> get _getRoutes => {
        ...getCommonRoutes(),
        ...getAuthRoutes(),
        ...getTitleRoutes(),
        ...getDictionaryRoutes(),
      };
}
