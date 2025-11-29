// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_match.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteMatchAdapter extends TypeAdapter<FavoriteMatch> {
  @override
  final typeId = 6;

  @override
  FavoriteMatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteMatch(
      matchId: (fields[0] as num?)?.toInt(),
      matchDate: fields[1] as DateTime?,
      leagueId: (fields[2] as num?)?.toInt(),
      leagueName: fields[3] as String?,
      leagueLogo: fields[4] as String?,
      homeTeamId: (fields[5] as num?)?.toInt(),
      homeTeamName: fields[6] as String?,
      homeTeamLogo: fields[7] as String?,
      awayTeamId: (fields[8] as num?)?.toInt(),
      awayTeamName: fields[9] as String?,
      awayTeamLogo: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteMatch obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.matchId)
      ..writeByte(1)
      ..write(obj.matchDate)
      ..writeByte(2)
      ..write(obj.leagueId)
      ..writeByte(3)
      ..write(obj.leagueName)
      ..writeByte(4)
      ..write(obj.leagueLogo)
      ..writeByte(5)
      ..write(obj.homeTeamId)
      ..writeByte(6)
      ..write(obj.homeTeamName)
      ..writeByte(7)
      ..write(obj.homeTeamLogo)
      ..writeByte(8)
      ..write(obj.awayTeamId)
      ..writeByte(9)
      ..write(obj.awayTeamName)
      ..writeByte(10)
      ..write(obj.awayTeamLogo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteMatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
