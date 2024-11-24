import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueTopScorersListTile extends StatelessWidget {
  final PlayerResponse? scorer;
  final String season;

  const LeagueTopScorersListTile({
    required this.scorer,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final numberOfGoals = scorer?.statistics?.fold(0, (sum, statistic) => sum + (statistic.goals?.total ?? 0));

    if ((numberOfGoals ?? 0) > 0) {
      return BalunButton(
        onPressed: scorer?.player?.id != null
            ? () => openPlayer(
                  context,
                  playerId: scorer!.player!.id!,
                  season: season,
                )
            : null,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BalunImage(
                  imageUrl: scorer?.player?.photo ?? BalunIcons.placeholderPlayer,
                  height: 48,
                  width: 48,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (scorer?.player?.name != null)
                    Text(
                      mixOrOriginalWords(scorer!.player!.name) ?? '---',
                      style: context.textStyles.leagueTeamsTitle,
                    ),
                  Text(
                    '$numberOfGoals ${'leagueTopScorersNumber'.tr()}',
                    style: context.textStyles.leagueTeamsCountry,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
