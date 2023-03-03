import 'package:flutter/material.dart';
import 'package:snowflake_client/title/screen/title.screen.dart';

enum TitleRoute {
  TITLE('/title');

  const TitleRoute(this.name);

  final String name;
}

Map<String, WidgetBuilder> getTitleRoutes() => {
      TitleRoute.TITLE.name: (context) => const TitleScreen(),
    };
