// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_fixture.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationFixtureAdapter extends TypeAdapter<NotificationFixture> {
  @override
  final typeId = 0;

  @override
  NotificationFixture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationFixture(
      fixtureId: (fields[0] as num?)?.toInt(),
      homeName: fields[1] as String?,
      awayName: fields[2] as String?,
      homeGoals: (fields[3] as num?)?.toInt(),
      awayGoals: (fields[4] as num?)?.toInt(),
      statusShort: fields[5] as String?,
      halfTimeNotified: fields[6] as bool?,
      extraTimeNotified: fields[7] as bool?,
      penaltiesNotified: fields[8] as bool?,
      fullTimeNotified: fields[9] as bool?,
      lastNotifiedTotalGoals: (fields[10] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, NotificationFixture obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.fixtureId)
      ..writeByte(1)
      ..write(obj.homeName)
      ..writeByte(2)
      ..write(obj.awayName)
      ..writeByte(3)
      ..write(obj.homeGoals)
      ..writeByte(4)
      ..write(obj.awayGoals)
      ..writeByte(5)
      ..write(obj.statusShort)
      ..writeByte(6)
      ..write(obj.halfTimeNotified)
      ..writeByte(7)
      ..write(obj.extraTimeNotified)
      ..writeByte(8)
      ..write(obj.penaltiesNotified)
      ..writeByte(9)
      ..write(obj.fullTimeNotified)
      ..writeByte(10)
      ..write(obj.lastNotifiedTotalGoals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationFixtureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
