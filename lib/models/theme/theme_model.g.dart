// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeModelAdapter extends TypeAdapter<ThemeModel> {
  @override
  final typeId = 2;

  @override
  ThemeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeModel(balunThemeEnum: fields[0] as BalunThemeEnum?);
  }

  @override
  void write(BinaryWriter writer, ThemeModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.balunThemeEnum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BalunThemeEnumAdapter extends TypeAdapter<BalunThemeEnum> {
  @override
  final typeId = 3;

  @override
  BalunThemeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BalunThemeEnum.light;
      case 1:
        return BalunThemeEnum.dark;
      case 2:
        return BalunThemeEnum.white;
      case 3:
        return BalunThemeEnum.blue;
      default:
        return BalunThemeEnum.light;
    }
  }

  @override
  void write(BinaryWriter writer, BalunThemeEnum obj) {
    switch (obj) {
      case BalunThemeEnum.light:
        writer.writeByte(0);
      case BalunThemeEnum.dark:
        writer.writeByte(1);
      case BalunThemeEnum.white:
        writer.writeByte(2);
      case BalunThemeEnum.blue:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BalunThemeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
