class League {
  final int? id;
  final String? name;
  final String? country;
  final String? logo;
  final String? flag;
  final String? season;
  final String? round;

  League({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.round,
  });

  factory League.fromMap(Map<String, dynamic> map) => League(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        country: map['country'] != null ? map['country'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
        flag: map['flag'] != null ? map['flag'] as String : null,
        season: map['season']?.toString(),
        round: map['round'] != null ? map['round'] as String : null,
      );

  @override
  String toString() => 'League(id: $id, name: $name, country: $country, logo: $logo, flag: $flag, season: $season, round: $round)';

  @override
  bool operator ==(covariant League other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.name == name && other.country == country && other.logo == logo && other.flag == flag && other.season == season && other.round == round;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ country.hashCode ^ logo.hashCode ^ flag.hashCode ^ season.hashCode ^ round.hashCode;
}
