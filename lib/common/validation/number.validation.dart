import 'package:flutter_riverpod/flutter_riverpod.dart';

final minValidationProvider = Provider((_) => (int value, {int min = 0}) => value >= min);

final maxValidationProvider = Provider((_) => (int value, {int max = 1}) => value <= max);

final minMaxValidationProvider = Provider(
  (_) => (int value, {int min = 0, int max = 1}) => value >= min && value <= max,
);
