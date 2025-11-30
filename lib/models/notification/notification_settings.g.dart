// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationSettingsAdapter extends TypeAdapter<NotificationSettings> {
  @override
  final typeId = 5;

  @override
  NotificationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationSettings(
      showLeagueNotifications: fields[0] as bool,
      showTeamNotifications: fields[1] as bool,
      showMatchNotifications: fields[2] as bool,
      triggerMatchStart: fields[3] as bool,
      triggerGoal: fields[4] as bool,
      triggerMatchProgress: fields[5] as bool,
      triggerFullTime: fields[6] as bool,
      playNotificationSound: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationSettings obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.showLeagueNotifications)
      ..writeByte(1)
      ..write(obj.showTeamNotifications)
      ..writeByte(2)
      ..write(obj.showMatchNotifications)
      ..writeByte(3)
      ..write(obj.triggerMatchStart)
      ..writeByte(4)
      ..write(obj.triggerGoal)
      ..writeByte(5)
      ..write(obj.triggerMatchProgress)
      ..writeByte(6)
      ..write(obj.triggerFullTime)
      ..writeByte(7)
      ..write(obj.playNotificationSound);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
