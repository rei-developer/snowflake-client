import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ITcpConnectionController extends StateNotifier<Socket?> {
  ITcpConnectionController(super.state);

  Future<bool> connect();

  Future<void> sendMessage(int packetId, Uint8List data);

  Future<void> close();

  bool get isConnected;
}
