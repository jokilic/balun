import 'package:easy_localization/easy_localization.dart';

enum LeagueSectionEnum {
  standings,
  fixtures,
  teams,
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
        LeagueSectionEnum.teams => 'leagueSectionTeams'.tr(),
        LeagueSectionEnum.standings => 'leagueSectionStandings'.tr(),
        LeagueSectionEnum.fixtures => 'leagueSectionFixtures'.tr(),
        LeagueSectionEnum.topScorers => 'leagueSectionScorers'.tr(),
        LeagueSectionEnum.topAssists => 'leagueSectionAssists'.tr(),
        LeagueSectionEnum.topYellowCards => 'leagueSectionYellowCards'.tr(),
        LeagueSectionEnum.topRedCards => 'leagueSectionRedCards'.tr(),
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
