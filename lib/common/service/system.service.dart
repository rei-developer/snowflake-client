import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ISystemService extends StateNotifier<DateTime> {
  ISystemService(super.state);

  void update([int seconds = 3]);

  Future<void> shutdown([bool isForce = false, int seconds = 3]);

  bool get isRun;

  Future<bool> get isConnected;
}
