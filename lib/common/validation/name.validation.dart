import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameValidationProvider = Provider(
  (_) => (String name, {int min = 2, int max = 6}) {
    final regex = RegExp('^([A-Za-z]{$min,$max}|[가-힣]{$min,$max})\$');
    return regex.hasMatch(name);
  },
);
