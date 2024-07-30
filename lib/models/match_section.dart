enum MatchSectionEnum {
  info,
  standings,
  events,
  lineups,
  headToHead,
  statistics,
  playerStatistics,
  injuries,
}

class MatchSection {
  final MatchSectionEnum matchSectionEnum;

  MatchSection({
    required this.matchSectionEnum,
  });

  String getMatchSectionName() => switch (matchSectionEnum) {
        MatchSectionEnum.info => 'Info',
        MatchSectionEnum.standings => 'Standings',
        MatchSectionEnum.events => 'Events',
        MatchSectionEnum.lineups => 'Lineups',
        MatchSectionEnum.headToHead => 'h2h',
        MatchSectionEnum.statistics => 'Statistics',
        MatchSectionEnum.playerStatistics => 'Player statistics',
        MatchSectionEnum.injuries => 'Injuries',
      };

  @override
  String toString() => 'MatchSection(matchSectionEnum: $matchSectionEnum)';

  @override
  bool operator ==(covariant MatchSection other) {
    if (identical(this, other)) {
      return true;
    }

    return other.matchSectionEnum == matchSectionEnum;
  }

  @override
  int get hashCode => matchSectionEnum.hashCode;
}
