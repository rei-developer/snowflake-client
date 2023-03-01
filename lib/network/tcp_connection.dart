import 'dart:io';
import 'dart:typed_data';

import 'package:snowflake_client/utils/packet_builder.util.dart';

class TcpConnection {
  late String host;
  late int port;
  Socket? _socket;

  TcpConnection(this.host, this.port);

  Future<void> connect() async {
    if (_isConnected) {
      return;
    }
    try {
      _socket = await Socket.connect(host, port);
      print('Connected to: ${_socket?.remoteAddress.address}:${_socket?.remotePort}');
      _socket?.listen(
        (data) {
          print('Received: ${String.fromCharCodes(data)}');
          // _socket?.destroy();
        },
        onError: (error) {
          print('Error: $error');
          // _socket?.destroy();
        },
        onDone: () {
          print('Connection closed!');
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  void sendMessage(int packetId, Uint8List data) {
    if (!_isConnected) {
      return;
    }
    final packet = PacketBuilder.buildPacket(packetId, data);
    _socket?.add(packet);
    print(packet);
  }

  bool get _isConnected => _socket != null;
}
