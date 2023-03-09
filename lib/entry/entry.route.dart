import 'package:flutter/material.dart';
import 'package:snowflake_client/entry/screen/entry.screen.dart';

enum CommonRoute {
  ENTRY('/');

  const CommonRoute(this.name);

  final String name;
}

Map<String, WidgetBuilder> getCommonRoutes() => {
      CommonRoute.ENTRY.name: (context) => const EntryScreen(),
    };
