import 'package:flutter/material.dart';

import '../../../../models/player_section.dart';
import '../../../../models/players/player_response.dart';
import 'sections/info/player_info_section.dart';
import 'sections/statistics/player_statistics_section.dart';

class PlayerActiveSection extends StatelessWidget {
  final PlayerResponse player;
  final PlayerSection playerSection;
  final int activeSeason;

  const PlayerActiveSection({
    required this.player,
    required this.playerSection,
    required this.activeSeason,
  });

  @override
  Widget build(BuildContext context) => switch (playerSection) {
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.info,
        ) =>
          PlayerInfoSection(
            player: player.player,
          ),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.statistics,
        ) =>
          PlayerStatisticsSection(
            playerId: player.player?.id,
            season: activeSeason,
          ),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.injuries,
        ) =>
          Container(),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.transfers,
        ) =>
          Container(),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.sidelined,
        ) =>
          Container(),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.trophies,
        ) =>
          Container(),
      };
}
