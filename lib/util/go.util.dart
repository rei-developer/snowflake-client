import 'package:flutter/cupertino.dart';

class Go {
  Go(this.context, [this.routeName]);

  final BuildContext context;
  final String? routeName;

  Future<dynamic> to([Object? arguments]) async =>
      Navigator.of(context, rootNavigator: true).pushNamed(routeName!, arguments: arguments);

  Future<dynamic> forceTo() async => Navigator.popAndPushNamed(context, routeName!);

  Future<dynamic> replace([Object? arguments]) async => Navigator.of(context, rootNavigator: true)
      .pushNamedAndRemoveUntil(routeName!, (route) => false, arguments: arguments);

  void pop<T extends Object?>([T? result]) => Navigator.pop(context, result);

  void forcePop() => Navigator.of(context, rootNavigator: true).pop();

  String get currentRouteName => ModalRoute.of(context)?.settings.name ?? '';

  bool get isCanPop => Navigator.canPop(context);
}
