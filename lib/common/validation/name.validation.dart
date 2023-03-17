import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameValidationProvider = Provider(
  (_) => (String name, {int enMin = 2, int enMax = 12, int koMin = 2, int koMax = 6}) {
    final regex = RegExp('^([A-Za-z]{$enMin,$enMax}|[가-힣]{$koMin,$koMax})\$');
    return regex.hasMatch(name);
  },
);
