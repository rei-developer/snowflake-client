import 'dart:typed_data';

import 'package:snowflake_client/util/json_to_binary.util.dart';

class VerifyTokenRequestDto {
  VerifyTokenRequestDto(this.token);

  final String token;

  Map<String, dynamic> toJson() => {'token': token};

  Uint8List toBinary() => jsonToBinary(toJson());
}
