import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_colors.dart';
import '../../../../../../models/fixtures/lineup/lineup_player.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_seperator.dart';

class MatchLineupList extends StatelessWidget {
  final List<LineupPlayer>? players;
  final LineupColors? playerColors;

  const MatchLineupList({
    required this.players,
    required this.playerColors,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: players?.length ?? 0,
        itemBuilder: (context, index) {
          final player = players![index].player;

          return BalunButton(
            onPressed: player?.id != null
                ? () => openPlayer(
                      context,
                      playerId: player!.id!,
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
                            player?.pos == 'G' ? playerColors?.goalkeeper?.primary : playerColors?.player?.primary,
                          ) ??
                          context.colors.white,
                      border: Border.all(
                        color: textToColor(
                              player?.pos == 'G' ? playerColors?.goalkeeper?.border : playerColors?.player?.border,
                            ) ??
                            context.colors.white,
                        width: 2.5,
                      ),
                    ),
                    child: Text(
                      '${player?.number ?? '-'}',
                      style: context.textStyles.matchLineupsSectionNumber.copyWith(
                        color: textToColor(
                              player?.pos == 'G' ? playerColors?.goalkeeper?.number : playerColors?.player?.number,
                            ) ??
                            context.colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    player?.name ?? '---',
                    style: context.textStyles.matchStandingsSectionText,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
