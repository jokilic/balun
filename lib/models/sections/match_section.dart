import 'package:easy_localization/easy_localization.dart';

enum MatchSectionEnum {
  info,
  events,
  highlights,
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
        MatchSectionEnum.info => 'matchSectionInfo'.tr(),
        MatchSectionEnum.events => 'matchSectionEvents'.tr(),
        MatchSectionEnum.highlights => 'matchSectionHighlights'.tr(),
        MatchSectionEnum.lineups => 'matchSectionLineups'.tr(),
        MatchSectionEnum.statistics => 'matchSectionStatistics'.tr(),
        MatchSectionEnum.playerStatistics => 'matchSectionPlayerStatistics'.tr(),
        MatchSectionEnum.standings => 'matchSectionStandings'.tr(),
        MatchSectionEnum.headToHead => 'matchSectionHeadToHead'.tr(),
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
