class TrophyResponse {
  final String? league;
  final String? country;
  final String? season;
  final String? place;

  TrophyResponse({
    this.league,
    this.country,
    this.season,
    this.place,
  });

  factory TrophyResponse.fromMap(Map<String, dynamic> map) => TrophyResponse(
        league: map['league'] != null ? map['league'] as String : null,
        country: map['country'] != null ? map['country'] as String : null,
        season: map['season'] != null ? map['season'] as String : null,
        place: map['place'] != null ? map['place'] as String : null,
      );

  @override
  String toString() => 'TrophyResponse(league: $league, country: $country, season: $season, place: $place)';

  @override
  bool operator ==(covariant TrophyResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.league == league && other.country == country && other.season == season && other.place == place;
  }

  @override
  int get hashCode => league.hashCode ^ country.hashCode ^ season.hashCode ^ place.hashCode;
}
