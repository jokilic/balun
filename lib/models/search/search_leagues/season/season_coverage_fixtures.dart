class SeasonCoverageFixtures {
  final bool? events;
  final bool? lineups;
  final bool? statisticsFixtures;
  final bool? statisticsPlayers;

  SeasonCoverageFixtures({
    this.events,
    this.lineups,
    this.statisticsFixtures,
    this.statisticsPlayers,
  });

  factory SeasonCoverageFixtures.fromMap(Map<String, dynamic> map) => SeasonCoverageFixtures(
        events: map['events'] != null ? map['events'] as bool : null,
        lineups: map['lineups'] != null ? map['lineups'] as bool : null,
        statisticsFixtures: map['statistics_fixtures'] != null ? map['statistics_fixtures'] as bool : null,
        statisticsPlayers: map['statistics_players'] != null ? map['statistics_players'] as bool : null,
      );

  @override
  String toString() => 'SeasonCoverageFixtures(events: $events, lineups: $lineups, statisticsFixtures: $statisticsFixtures, statisticsPlayers: $statisticsPlayers)';

  @override
  bool operator ==(covariant SeasonCoverageFixtures other) {
    if (identical(this, other)) {
      return true;
    }

    return other.events == events && other.lineups == lineups && other.statisticsFixtures == statisticsFixtures && other.statisticsPlayers == statisticsPlayers;
  }

  @override
  int get hashCode => events.hashCode ^ lineups.hashCode ^ statisticsFixtures.hashCode ^ statisticsPlayers.hashCode;
}
