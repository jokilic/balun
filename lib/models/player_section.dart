enum PlayerSectionEnum {
  info,
  statistics,
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
        PlayerSectionEnum.info => 'Info',
        PlayerSectionEnum.statistics => 'Statistics',
        PlayerSectionEnum.transfers => 'Transfers',
        PlayerSectionEnum.sidelined => 'Sidelined',
        PlayerSectionEnum.trophies => 'Trophies',
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
