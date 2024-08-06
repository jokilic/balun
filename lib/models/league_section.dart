enum LeagueSectionEnum {
  teams,
  standings,
  fixtures,
  topScorers,
  topAssists,
  topYellowCards,
  topRedCards,
}

class LeagueSection {
  final LeagueSectionEnum leagueSectionEnum;

  LeagueSection({
    required this.leagueSectionEnum,
  });

  String getLeagueSectionName() => switch (leagueSectionEnum) {
        LeagueSectionEnum.teams => 'Teams',
        LeagueSectionEnum.standings => 'Standings',
        LeagueSectionEnum.fixtures => 'Fixtures',
        LeagueSectionEnum.topScorers => 'Scorers',
        LeagueSectionEnum.topAssists => 'Assists',
        LeagueSectionEnum.topYellowCards => 'Yellow cards',
        LeagueSectionEnum.topRedCards => 'Red cards',
      };

  @override
  String toString() => 'LeagueSection(leagueSectionEnum: $leagueSectionEnum)';

  @override
  bool operator ==(covariant LeagueSection other) {
    if (identical(this, other)) {
      return true;
    }

    return other.leagueSectionEnum == leagueSectionEnum;
  }

  @override
  int get hashCode => leagueSectionEnum.hashCode;
}
