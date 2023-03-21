import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetLoader {
  AssetLoader(this.path);

  final String path;

  Widget image([double? width, double? height, Color? color]) =>
      isSvg ? _renderSvgPicture(width, height, color) : _renderImage(width, height);

  Widget _renderSvgPicture([double? width, double? height, Color? color]) =>
      SvgPicture.asset(_path, width: width, height: height, color: color);

  Widget _renderImage([double? width, double? height]) =>
      Image.asset(_path, width: width, height: height, filterQuality: FilterQuality.high);

  DecorationImage get cover => DecorationImage(fit: BoxFit.cover, image: AssetImage(_path));

  String get _path => 'assets/$path';

  Future<String> get fromJson async => rootBundle.loadString(_path);

  Future<dynamic> get decodeJson async => json.decode(await fromJson);

  bool get isSvg => path.split('.')[1] == 'svg';
}
