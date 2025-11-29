import 'package:hive_ce/hive.dart';

part 'theme_model.g.dart';

@HiveType(typeId: 3)
enum BalunThemeEnum {
  @HiveField(0)
  light,
  @HiveField(1)
  dark,
  @HiveField(2)
  white,
  @HiveField(3)
  blue,
}

@HiveType(typeId: 2)
class ThemeModel {
  @HiveField(0)
  final BalunThemeEnum? balunThemeEnum;

  ThemeModel({
    this.balunThemeEnum,
  });

  @override
  String toString() => 'ThemeModel(balunThemeEnum: $balunThemeEnum)';

  @override
  bool operator ==(covariant ThemeModel other) {
    if (identical(this, other)) {
      return true;
    }

    return other.balunThemeEnum == balunThemeEnum;
  }

  @override
  int get hashCode => balunThemeEnum.hashCode;
}
