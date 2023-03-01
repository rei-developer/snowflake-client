import 'dart:convert';
import 'dart:typed_data';

Uint8List jsonToBinary(Map<String, dynamic> json) =>
    Uint8List.fromList(utf8.encode(jsonEncode(json))).buffer.asUint8List();
