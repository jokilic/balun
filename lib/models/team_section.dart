enum TeamSectionEnum {
  stadium,
  leagues,
  standings,
  coaches,
  players,
  transfers,
}

class TeamSection {
  final TeamSectionEnum teamSectionEnum;

  TeamSection({
    required this.teamSectionEnum,
  });

  String getTeamSectionName() => switch (teamSectionEnum) {
        TeamSectionEnum.stadium => 'Stadium',
        TeamSectionEnum.leagues => 'Leagues',
        TeamSectionEnum.standings => 'Standings',
        TeamSectionEnum.coaches => 'Coaches',
        TeamSectionEnum.players => 'Players',
        TeamSectionEnum.transfers => 'Transfers',
      };

  @override
  String toString() => 'TeamSection(teamSectionEnum: $teamSectionEnum)';

  @override
  bool operator ==(covariant TeamSection other) {
    if (identical(this, other)) {
      return true;
    }

    return other.teamSectionEnum == teamSectionEnum;
  }

  @override
  int get hashCode => teamSectionEnum.hashCode;
}
