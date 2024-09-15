import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueTopYellowCardsListTile extends StatelessWidget {
  final PlayerResponse? yellowCard;
  final int season;

  const LeagueTopYellowCardsListTile({
    required this.yellowCard,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final numberOfCards = yellowCard?.statistics?.fold(0, (sum, statistic) => sum + (statistic.cards?.yellow ?? 0) + (statistic.cards?.yellowRed ?? 0));

    if ((numberOfCards ?? 0) > 0) {
      return BalunButton(
        onPressed: yellowCard?.player?.id != null
            ? () => openPlayer(
                  context,
                  playerId: yellowCard!.player!.id!,
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
                  imageUrl: yellowCard?.player?.photo ?? BalunIcons.placeholderPlayer,
                  height: 48,
                  width: 48,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (yellowCard?.player?.name != null)
                    Text(
                      yellowCard!.player!.name!,
                      style: context.textStyles.leagueTeamsTitle,
                    ),
                  Text(
                    '$numberOfCards ${'leagueTopYellowCardsNumber'.tr()}',
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
