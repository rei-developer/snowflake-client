enum ServiceServerResponsePacket {
  generatedLoverHash,
}

ServiceServerResponsePacket? getServiceServerResponsePacket(int index) =>
    ServiceServerResponsePacket.values[index - 1];
