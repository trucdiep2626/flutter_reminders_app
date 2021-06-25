// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../domain/entities/reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 2;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder(
      id: fields[0] as int,
      title: fields[1] as String,
      notes: fields[2] as String,
      list: fields[3] as String,
      dateAndTime: fields[4] as int,
      createAt: fields[5] as int,
      lastUpdate: fields[6] as int,
      priority: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.list)
      ..writeByte(4)
      ..write(obj.dateAndTime)
      ..writeByte(5)
      ..write(obj.createAt)
      ..writeByte(6)
      ..write(obj.lastUpdate)
      ..writeByte(7)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
