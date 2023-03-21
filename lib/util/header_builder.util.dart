import 'dart:typed_data';

class HeaderBuilder {
  static const int HEADER_LENGTH = 8;

  static Uint8List buildHeader(int packetId, int dataLength) {
    final header = Uint8List(HEADER_LENGTH);
    ByteData.view(header.buffer)
      ..setUint32(0, packetId)
      ..setUint32(4, dataLength);
    return header;
  }
}
