import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class IEntryController extends StateNotifier<bool> {
  IEntryController(super.state);

  Future<bool> init();

  Future<void> next();

  Future<void> checkConnection();
}
