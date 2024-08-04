import 'package:flutter/foundation.dart';

import 'country/country.dart';
import 'league/league.dart';
import 'season/season.dart';

class LeagueResponse {
  final League? league;
  final Country? country;
  final List<Season>? seasons;

  LeagueResponse({
    this.league,
    this.country,
    this.seasons,
  });

  factory LeagueResponse.fromMap(Map<String, dynamic> map) => LeagueResponse(
        league: map['league'] != null ? League.fromMap(map['league'] as Map<String, dynamic>) : null,
        country: map['country'] != null ? Country.fromMap(map['country'] as Map<String, dynamic>) : null,
        seasons: map['seasons'] != null
            ? List<Season>.from(
                (map['seasons'] as List).map<Season?>(
                  (x) => Season.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'LeagueResponse(league: $league, country: $country, seasons: $seasons)';

  @override
  bool operator ==(covariant LeagueResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.league == league && other.country == country && listEquals(other.seasons, seasons);
  }

  @override
  int get hashCode => league.hashCode ^ country.hashCode ^ seasons.hashCode;
}
