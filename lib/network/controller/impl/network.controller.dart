import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/auth/service/sign-up.service.dart';
import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/network/controller/network.controller.dart';
import 'package:snowflake_client/utils/packet_builder.util.dart';

class TcpConnectionController extends ITcpConnectionController {
  TcpConnectionController(this.ref, this.config) : super(null);

  final Ref ref;
  final ServerConfig config;

  final _messageStreamController = StreamController<Uint8List>.broadcast();
  final _errorStreamController = StreamController<Object>.broadcast();
  final _doneStreamController = StreamController<void>.broadcast();

  ISignUpService get _signUpService => ref.read(signUpServiceProvider);

  Stream<Uint8List> get messageStream => _messageStreamController.stream;

  Stream<Object> get errorStream => _errorStreamController.stream;

  Stream<void> get doneStream => _doneStreamController.stream;

  late StreamSubscription<Uint8List> _subscription;

  @override
  Future<bool> connect() async {
    if (state != null) {
      return true;
    }
    try {
      state = await Socket.connect(config.host, config.port);
      print('Connected to: ${state?.remoteAddress.address}:${state?.remotePort}');
      _subscription = state!.listen(
        _handleData,
        onError: (error) {
          _errorStreamController.add(error);
          close();
        },
        onDone: close,
      );
      return true;
    } on SocketException catch (e) {
      _errorStreamController.add(e);
      rethrow;
    } catch (e) {
      _errorStreamController.add(e);
      print('Error: $e');
    }
    return false;
  }

  @override
  Future<void> sendMessage(int packetId, Uint8List data) async {
    if (state == null) {
      return;
    }
    final packet = PacketBuilder.buildPacket(packetId, data);
    state!.add(packet);
  }

  @override
  Future<void> close() async {
    if (state == null) {
      return;
    }
    await _subscription.cancel();
    await state?.close();
    state = null;
    await _messageStreamController.close();
    await _errorStreamController.close();
    await _doneStreamController.close();
  }

  @override
  bool get isConnected => state != null && !state!.isBroadcast && state!.remotePort != 0;

  Future<void> _handleData(Uint8List data) async {
    final buffer = data.buffer;
    final dataView = buffer.asByteData();
    final decoder = utf8.decoder;
    int offset = 0;
    while (offset < data.length) {
      final packetSize = dataView.getUint32(offset, Endian.big);
      if (offset + packetSize > data.length) {
        break;
      }
      final packetId = dataView.getUint32(offset + 4, Endian.big);
      final packetData = data.buffer.asUint8List(offset + 8, packetSize - 8);
      try {
        final jsonStr = decoder.convert(packetData).replaceAll('\u{0000}', '');
        final jsonMap = jsonDecode(jsonStr);
        await _handlePacket(packetId, jsonMap);
      } catch (err) {
        print('TcpConnectionController handleData error: $err');
        return;
      } finally {
        offset += packetSize;
      }
    }
  }

  Future<void> _handlePacket(int packetId, Map<String, dynamic> json) async {
    switch (packetId) {
      case 134:
        _signUpService.setDrawFirstLoverHash(json);
        break;
      default:
        break;
    }
  }
}
