enum MatchSectionEnum {
  info,
  league,
  events,
  lineups,
  formations,
  headToHead,
  statistics,
  injuries,
}

class MatchSection {
  final MatchSectionEnum matchSectionEnum;

  MatchSection({
    required this.matchSectionEnum,
  });

  String getMatchSectionName() => switch (matchSectionEnum) {
        MatchSectionEnum.info => 'Info',
        MatchSectionEnum.league => 'League',
        MatchSectionEnum.events => 'Events',
        MatchSectionEnum.lineups => 'Lineups',
        MatchSectionEnum.formations => 'Formations',
        MatchSectionEnum.headToHead => 'h2h',
        MatchSectionEnum.statistics => 'Statistics',
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
