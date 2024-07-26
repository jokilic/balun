// ignore_for_file: unnecessary_lambdas

import 'package:flutter/foundation.dart';

import '../standing/team_standing.dart';

class League {
  final int? id;
  final String? name;
  final String? country;
  final String? logo;
  final String? flag;
  final int? season;
  final List<List<TeamStanding>>? standings;

  League({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.standings,
  });

  factory League.fromMap(Map<String, dynamic> map) => League(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        country: map['country'] != null ? map['country'] as String : null,
        logo: map['logo'] != null ? map['logo'] as String : null,
        flag: map['flag'] != null ? map['flag'] as String : null,
        season: map['season'] != null ? map['season'] as int : null,
        standings: map['standings'] != null
            ? List<List<TeamStanding>>.from(
                map['standings'].map(
                  (standingList) => List<TeamStanding>.from(
                    standingList.map(
                      (standing) => TeamStanding.fromMap(standing),
                    ),
                  ),
                ),
              )
            : null,
      );

  @override
  String toString() => 'League(id: $id, name: $name, country: $country, logo: $logo, flag: $flag, season: $season, standings: $standings)';

  @override
  bool operator ==(covariant League other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id &&
        other.name == name &&
        other.country == country &&
        other.logo == logo &&
        other.flag == flag &&
        other.season == season &&
        listEquals(other.standings, standings);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ country.hashCode ^ logo.hashCode ^ flag.hashCode ^ season.hashCode ^ standings.hashCode;
}
