// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_icon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavIconAdapter extends TypeAdapter<FavIcon> {
  @override
  final int typeId = 1;

  @override
  FavIcon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavIcon(
      icon: fields[1] as IosIcon,
    );
  }

  @override
  void write(BinaryWriter writer, FavIcon obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavIconAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
