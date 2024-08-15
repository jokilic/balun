import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/players/player_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueTopScorersListTile extends StatelessWidget {
  final PlayerResponse? scorer;

  const LeagueTopScorersListTile({
    required this.scorer,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: scorer?.player?.id != null
            ? () => openPlayer(
                  context,
                  playerId: scorer!.player!.id!,
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
                  imageUrl: scorer?.player?.photo ?? BalunImages.placeholderLogo,
                  height: 56,
                  width: 56,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (scorer?.player?.name != null)
                    Text(
                      scorer!.player!.name!,
                      style: context.textStyles.leagueTeamsTitle,
                    ),
                  if (scorer?.statistics?.isNotEmpty ?? false)
                    Text(
                      '${scorer!.statistics!.fold(0, (sum, statistic) => sum + (statistic.goals?.total ?? 0))} goals',
                      style: context.textStyles.leagueTeamsCountry,
                    ),
                ],
              ),
            ],
          ),
        ),
      );
}
