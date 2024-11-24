import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_colors.dart';
import '../../../../../../models/fixtures/lineup/lineup_player.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic_data.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class MatchLineupListTile extends StatelessWidget {
  final bool matchLive;
  final LineupPlayerInside? player;
  final PlayerStatisticData? playerStatistic;
  final LineupColors? colors;
  final String season;

  const MatchLineupListTile({
    required this.matchLive,
    required this.player,
    required this.playerStatistic,
    required this.colors,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final minutesPlayed = playerStatistic?.statistic?.fold(
      0,
      (sum, statistic) => sum + (statistic.games?.minutes ?? 0),
    );

    return BalunButton(
      onPressed: player?.id != null
          ? () => openPlayer(
                context,
                playerId: player!.id!,
                season: season,
              )
          : null,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ///
            /// CIRCLE WITH NUMBER
            ///
            Container(
              alignment: Alignment.center,
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: textToColor(
                      player?.pos == 'G' ? colors?.goalkeeper?.primary : colors?.player?.primary,
                    ) ??
                    context.colors.white,
                border: Border.all(
                  color: textToColor(
                        player?.pos == 'G' ? colors?.goalkeeper?.border : colors?.player?.border,
                      ) ??
                      context.colors.white,
                  width: 2.5,
                ),
              ),
              child: Text(
                '${player?.number ?? '-'}',
                style: context.textStyles.matchLineupsSectionNumber.copyWith(
                  color: textToColor(
                        player?.pos == 'G' ? colors?.goalkeeper?.number : colors?.player?.number,
                      ) ??
                      context.colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),

            ///
            /// NAME
            ///
            Flexible(
              child: Text(
                mixOrOriginalWords(getLastWord(player?.name ?? '---')) ?? '---',
                style: context.textStyles.matchStandingsSectionText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            ///
            /// SUBSTITUTION
            ///
            if (!matchLive)
              if ((minutesPlayed ?? 0) > 0) ...[
                const SizedBox(width: 4),
                BalunImage(
                  imageUrl: BalunIcons.playerIn,
                  color: context.colors.green,
                  height: 24,
                  width: 24,
                ),
              ]
          ],
        ),
      ),
    );
  }
}
