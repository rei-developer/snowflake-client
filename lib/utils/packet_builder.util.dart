import 'dart:typed_data';

import 'package:snowflake_client/utils/header_builder.util.dart';

class PacketBuilder {
  static Uint8List buildPacket(int packetId, Uint8List data) {
    final header = HeaderBuilder.buildHeader(packetId, data.lengthInBytes);
    return Uint8List(header.length + data.length)
      ..setAll(0, header)
      ..setAll(header.length, data);
  }
}
