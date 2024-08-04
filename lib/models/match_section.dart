enum MatchSectionEnum {
  info,
  events,
  lineups,
  statistics,
  playerStatistics,
  standings,
  headToHead,
}

class MatchSection {
  final MatchSectionEnum matchSectionEnum;

  MatchSection({
    required this.matchSectionEnum,
  });

  String getMatchSectionName() => switch (matchSectionEnum) {
        MatchSectionEnum.info => 'Info',
        MatchSectionEnum.events => 'Events',
        MatchSectionEnum.lineups => 'Lineups',
        MatchSectionEnum.statistics => 'Statistics',
        MatchSectionEnum.playerStatistics => 'Player statistics',
        MatchSectionEnum.standings => 'Standings',
        MatchSectionEnum.headToHead => 'Head-to-head',
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
