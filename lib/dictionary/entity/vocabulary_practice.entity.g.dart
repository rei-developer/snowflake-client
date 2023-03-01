// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_practice.entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyPracticeEntityAdapter
    extends TypeAdapter<VocabularyPracticeEntity> {
  @override
  final int typeId = 2;

  @override
  VocabularyPracticeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyPracticeEntity(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyPracticeEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.maxRound)
      ..writeByte(1)
      ..write(obj.maxLife)
      ..writeByte(2)
      ..write(obj.timeLimit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyPracticeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
