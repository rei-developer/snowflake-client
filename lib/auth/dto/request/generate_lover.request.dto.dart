import 'dart:typed_data';

import 'package:snowflake_client/util/json_to_binary.util.dart';

class GenerateLoverRequestDto {
  GenerateLoverRequestDto(
    this.name,
    this.race,
    this.sex,
    this.age,
    this.hairColor,
    this.hairShape,
    this.hairStyle,
    this.face,
    this.eyes,
    this.nose,
    this.mouth,
    this.ears,
    this.body,
    this.breast,
  );

  final String name;
  final int race;
  final int sex;
  final int age;
  final String hairColor;
  final String hairShape;
  final String hairStyle;
  final String face;
  final String eyes;
  final String nose;
  final String mouth;
  final String ears;
  final String body;
  final String breast;

  Map<String, dynamic> toJson() => {
        'name': name,
        'race': race,
        'sex': sex,
        'age': age,
        'hairColor': hairColor,
        'hairShape': hairShape,
        'hairStyle': hairStyle,
        'face': face,
        'eyes': eyes,
        'nose': nose,
        'mouth': mouth,
        'ears': ears,
        'body': body,
        'breast': breast,
      };

  Uint8List toBinary() => jsonToBinary(toJson());
}
