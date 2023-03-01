import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ISystemController extends StateNotifier<String> {
  ISystemController(super.state);

  Future<void> init();
}
