import 'package:hive_ce/hive.dart';

part 'team.g.dart';

@HiveType(typeId: 1)
class Team {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? code;
  @HiveField(3)
  final String? country;
  @HiveField(4)
  final int? founded;
  @HiveField(5)
  final bool? national;
  @HiveField(6)
  final String? logo;

  Team({
    this.id,
    this.name,
    this.code,
    this.country,
    this.founded,
    this.national,
    this.logo,
  });

  factory Team.fromMap(Map<String, dynamic> map) => Team(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        code: map['code'] != null ? map['code'] as String : null,
        country: map['country'] != null ? map['country'] as String : null,
        founded: map['founded'] != null ? map['founded'] as int : null,
        national: map['national'] != null ? map['national'] as bool : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
      );

  @override
  String toString() => 'Team(id: $id, name: $name, code: $code, country: $country, founded: $founded, national: $national, logo: $logo)';

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.code == code && other.country == country && other.founded == founded && other.national == national && other.logo == logo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode ^ country.hashCode ^ founded.hashCode ^ national.hashCode ^ logo.hashCode;
}
