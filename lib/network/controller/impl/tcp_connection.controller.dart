import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/provider/sign-up.provider.dart';
import 'package:snowflake_client/auth/service/sign-up.service.dart';
import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/network/const/service-server/response_packet.const.dart';
import 'package:snowflake_client/network/controller/tcp_connection.controller.dart';
import 'package:snowflake_client/network/handler/impl/service-server.handler.dart';
import 'package:snowflake_client/network/handler/server.handler.dart';
import 'package:snowflake_client/util/packet_builder.util.dart';

class TcpConnectionController extends ITcpConnectionController {
  TcpConnectionController(this.ref, this.config) : super(null);

  final Ref ref;
  final ServerConfig config;

  final _messageStreamController = StreamController<Uint8List>.broadcast();
  final _errorStreamController = StreamController<Object>.broadcast();
  final _doneStreamController = StreamController<void>.broadcast();

  static final _dataView = ByteData.view(Uint8List(4096).buffer);
  static final _decoder = utf8.decoder;

  int _offset = 0;

  late StreamSubscription<Uint8List> _subscription;
  late final IServerHandler _serviceServerPacketHandler = ServiceServerHandler(_signUpService);

  ISignUpService get _signUpService => ref.read(signUpServiceProvider);

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
    } on SocketException catch (err) {
      print('TcpConnectionController connect error => $err');
      _errorStreamController.add(err);
      rethrow;
    } catch (err) {
      print('TcpConnectionController connect error => $err');
      _errorStreamController.add(err);
    }
    return false;
  }

  @override
  Future<void> sendMessage(int packetId, Uint8List data) async {
    if (state == null) {
      return;
    }
    state!.add(PacketBuilder.buildPacket(packetId, data));
  }

  @override
  Future<void> close() async {
    if (state == null) {
      return;
    }
    await _messageStreamController.close();
    await _errorStreamController.close();
    await _doneStreamController.close();
    await _subscription.cancel();
    await state?.close();
    state = null;
  }

  @override
  bool get isConnected => state != null && !state!.isBroadcast && state!.remotePort != 0;

  void _handleData(Uint8List data) {
    int i = 0;
    final dataLength = data.length;
    while (i < dataLength) {
      final bytesToCopy = min(dataLength - i, _dataView.lengthInBytes - _offset);
      _dataView.buffer.asUint8List(_offset, bytesToCopy).setRange(0, bytesToCopy, data, i);
      i += bytesToCopy;
      _offset += bytesToCopy;
      if (_offset >= 4) {
        final packetSize = _dataView.getUint32(0, Endian.big);
        if (_offset >= packetSize) {
          final packetId = _dataView.getUint32(4, Endian.big);
          final packetData = _dataView.buffer.asUint8List(8, packetSize - 8);
          try {
            final jsonStr = _decoder.convert(packetData).replaceAll('\u{0000}', '');
            final jsonMap = jsonDecode(jsonStr);
            _handlePacket(packetId, jsonMap);
          } finally {
            _dataView.buffer.asUint8List().fillRange(0, _offset, 0);
            _offset = 0;
          }
        }
      }
    }
  }

  void _handlePacket(int packetId, Map<String, dynamic> json) {
    try {
      print('packetId => $packetId');
      switch (config.serverType) {
        case ServerType.chat:
          break;
        case ServerType.map:
          break;
        case ServerType.service:
          _serviceServerPacketHandler.handle(getServiceServerResponsePacket(packetId), json);
          break;
      }
    } catch (err) {
      print('TcpConnectionController handlePacket error => $err');
    }
  }
}
