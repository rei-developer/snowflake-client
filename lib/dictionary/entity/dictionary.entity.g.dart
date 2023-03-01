// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary.entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DictionaryEntityAdapter extends TypeAdapter<DictionaryEntity> {
  @override
  final int typeId = 0;

  @override
  DictionaryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DictionaryEntity(
      fields[0] as int,
      fields[1] as String,
      (fields[2] as List).cast<WordEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, DictionaryEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.words);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DictionaryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
