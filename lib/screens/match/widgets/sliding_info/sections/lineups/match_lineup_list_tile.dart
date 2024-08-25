import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_colors.dart';
import '../../../../../../models/fixtures/lineup/lineup_player.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/string.dart';
import '../../../../../../widgets/balun_button.dart';

class MatchLineupListTile extends StatelessWidget {
  final LineupPlayerInside? player;
  final LineupColors? colors;
  final int season;

  const MatchLineupListTile({
    required this.player,
    required this.colors,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
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
              Expanded(
                child: Text(
                  getLastWord(player?.name ?? '---'),
                  style: context.textStyles.matchStandingsSectionText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      );
}
