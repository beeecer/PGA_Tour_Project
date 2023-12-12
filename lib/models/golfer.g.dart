// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'golfer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GolferAdapter extends TypeAdapter<Golfer> {
  @override
  final int typeId = 0;

  @override
  Golfer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Golfer(
      fields[0] as String,
      fields[1] as int,
      isFavorite: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Golfer obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.points)
      ..writeByte(2)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GolferAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
