import 'package:flutter/material.dart';

import '../../../../models/player_section.dart';
import '../../../../models/players/player_response.dart';
import 'sections/info/player_info_section.dart';
import 'sections/sidelined/player_sidelined_section.dart';
import 'sections/statistics/player_statistics_section.dart';
import 'sections/teams/player_teams_section.dart';
import 'sections/transfers/player_transfers_section.dart';
import 'sections/trophies/player_trophies_section.dart';

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
          playerSectionEnum: PlayerSectionEnum.teams,
        ) =>
          PlayerTeamsSection(
            playerId: player.player?.id,
          ),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.transfers,
        ) =>
          PlayerTransfersSection(
            playerId: player.player?.id,
          ),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.sidelined,
        ) =>
          PlayerSidelinedSection(
            playerId: player.player?.id,
          ),
        PlayerSection(
          playerSectionEnum: PlayerSectionEnum.trophies,
        ) =>
          PlayerTrophiesSection(
            playerId: player.player?.id,
          ),
      };
}
