// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterReminderAdapter extends TypeAdapter<WaterReminder> {
  @override
  int get typeId => 5;
  @override
  WaterReminder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterReminder(
      ml: fields[0] as int,
      id: fields[2] as String,
      dateTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WaterReminder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.ml)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.id);
  }
}
