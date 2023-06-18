// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataModelHiveAdapter extends TypeAdapter<DataModelHive> {
  @override
  final int typeId = 1;

  @override
  DataModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataModelHive(
      dataID: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      expiryDate: fields[3] as DateTime,
      fileSize: fields[4] as double,
      filePath: fields[5] as String,
      documentType: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.dataID)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.fileSize)
      ..writeByte(5)
      ..write(obj.filePath)
      ..writeByte(6)
      ..write(obj.documentType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
