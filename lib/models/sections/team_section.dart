import 'package:easy_localization/easy_localization.dart';

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
        TeamSectionEnum.stadium => 'teamSectionStadium'.tr(),
        TeamSectionEnum.leagues => 'teamSectionLeagues'.tr(),
        TeamSectionEnum.standings => 'teamSectionStandings'.tr(),
        TeamSectionEnum.coaches => 'teamSectionCoaches'.tr(),
        TeamSectionEnum.players => 'teamSectionPlayers'.tr(),
        TeamSectionEnum.transfers => 'teamSectionTransfers'.tr(),
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
