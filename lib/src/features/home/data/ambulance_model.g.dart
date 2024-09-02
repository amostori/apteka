// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambulance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmbulanceAdapter extends TypeAdapter<Ambulance> {
  @override
  final int typeId = 1;

  @override
  Ambulance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ambulance(
      ambulanceId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ambulance obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.ambulanceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmbulanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
