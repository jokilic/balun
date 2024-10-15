class StatisticLeague {
  final int? id;
  final String? name;
  final String? country;
  final String? logo;
  final String? flag;
  final String? season;

  StatisticLeague({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
  });

  factory StatisticLeague.fromMap(Map<String, dynamic> map) => StatisticLeague(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        country: map['country'] != null ? map['country'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
        flag: map['flag'] != null ? map['flag'] as String : null,
        season: map['season']?.toString(),
      );

  @override
  String toString() => 'StatisticLeague(id: $id, name: $name, country: $country, logo: $logo, flag: $flag, season: $season)';

  @override
  bool operator ==(covariant StatisticLeague other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.country == country && other.logo == logo && other.flag == flag && other.season == season;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ country.hashCode ^ logo.hashCode ^ flag.hashCode ^ season.hashCode;
}
