import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/network/controller/network.controller.dart';
import 'package:snowflake_client/utils/packet_builder.util.dart';

class TcpConnectionController extends ITcpConnectionController {
  TcpConnectionController(this.serverConfig) : super(null) {
    _initTransformer();
  }

  final ServerConfig serverConfig;

  final _messageStreamController = StreamController<Uint8List>.broadcast();
  final _errorStreamController = StreamController<Object>.broadcast();
  final _doneStreamController = StreamController<void>.broadcast();

  late StreamTransformer<Uint8List, Uint8List> _transformer;

  Stream<Uint8List> get messageStream => _messageStreamController.stream.transform(_transformer);

  Stream<Object> get errorStream => _errorStreamController.stream;

  Stream<void> get doneStream => _doneStreamController.stream;

  @override
  Future<bool> connect() async {
    if (state != null) {
      return true;
    }
    print("Z ${serverConfig.host} ${serverConfig.port}");
    try {
      state = await Socket.connect(serverConfig.host, serverConfig.port);
      print('Connected to: ${state?.remoteAddress.address}:${state?.remotePort}');
      state?.transform(_transformer).listen(
        _messageStreamController.sink.add,
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
    print("A");
    if (state == null) {
      print("B");
      return;
    }
    print("C");
    final packet = PacketBuilder.buildPacket(packetId, data);
    state?.add(packet);
    print(packet);
  }

  @override
  Future<void> close() async {
    if (state == null) {
      return;
    }
    await state?.close();
    state = null;
    await _messageStreamController.close();
    await _errorStreamController.close();
    await _doneStreamController.close();
  }

  @override
  bool get isConnected {
    if (state == null) {
      return false;
    }
    return !state!.isBroadcast && state!.remotePort != 0;
  }

  void _initTransformer() {
    _transformer = StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        print('Received: ${String.fromCharCodes(data)}');
        sink.add(data);
      },
      handleError: (error, stackTrace, sink) async {
        print('Error: $error');
        _errorStreamController.add(error);
        await close();
      },
      handleDone: (sink) async {
        print('Connection closed!');
        _doneStreamController.add(null);
        await close();
      },
    );
  }
}
