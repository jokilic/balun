import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/players/player_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueTopAssistsListTile extends StatelessWidget {
  final PlayerResponse? assist;
  final int season;

  const LeagueTopAssistsListTile({
    required this.assist,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: assist?.player?.id != null
            ? () => openPlayer(
                  context,
                  playerId: assist!.player!.id!,
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
                  imageUrl: assist?.player?.photo ?? BalunImages.placeholderIcon,
                  height: 56,
                  width: 56,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (assist?.player?.name != null)
                    Text(
                      assist!.player!.name!,
                      style: context.textStyles.leagueTeamsTitle,
                    ),
                  if (assist?.statistics?.isNotEmpty ?? false)
                    Text(
                      '${assist!.statistics!.fold(0, (sum, statistic) => sum + (statistic.goals?.assists ?? 0))} assists',
                      style: context.textStyles.leagueTeamsCountry,
                    ),
                ],
              ),
            ],
          ),
        ),
      );
}
