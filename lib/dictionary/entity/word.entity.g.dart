// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordEntityAdapter extends TypeAdapter<WordEntity> {
  @override
  final int typeId = 1;

  @override
  WordEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordEntity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WordEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.definition)
      ..writeByte(2)
      ..write(obj.partOfSpeech);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
