import 'package:easy_localization/easy_localization.dart';

enum PlayerSectionEnum {
  info,
  statistics,
  teams,
  transfers,
  sidelined,
  trophies,
}

class PlayerSection {
  final PlayerSectionEnum playerSectionEnum;

  PlayerSection({
    required this.playerSectionEnum,
  });

  String getPlayerSectionName() => switch (playerSectionEnum) {
        PlayerSectionEnum.info => 'playerSectionInfo'.tr(),
        PlayerSectionEnum.statistics => 'playerSectionStatistics'.tr(),
        PlayerSectionEnum.teams => 'playerSectionTeams'.tr(),
        PlayerSectionEnum.transfers => 'playerSectionTransfers'.tr(),
        PlayerSectionEnum.sidelined => 'playerSectionSidelined'.tr(),
        PlayerSectionEnum.trophies => 'playerSectionTrophies'.tr(),
      };

  @override
  String toString() => 'PlayerSection(playerSectionEnum: $playerSectionEnum)';

  @override
  bool operator ==(covariant PlayerSection other) {
    if (identical(this, other)) {
      return true;
    }

    return other.playerSectionEnum == playerSectionEnum;
  }

  @override
  int get hashCode => playerSectionEnum.hashCode;
}
