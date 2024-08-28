import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/players/player_response.dart';
import '../../../../../../routing.dart';
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
  Widget build(BuildContext context) => BalunButton(
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
                  imageUrl: yellowCard?.player?.photo ?? BalunImages.placeholderPlayer,
                  height: 56,
                  width: 56,
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
                  if (yellowCard?.statistics?.isNotEmpty ?? false)
                    Text(
                      '${yellowCard!.statistics!.fold(0, (sum, statistic) => sum + (statistic.cards?.yellow ?? 0))} yellow cards',
                      style: context.textStyles.leagueTeamsCountry,
                    ),
                ],
              ),
            ],
          ),
        ),
      );
}
