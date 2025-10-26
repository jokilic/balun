import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueTopAssistsListTile extends StatelessWidget {
  final PlayerResponse? assist;
  final String season;

  const LeagueTopAssistsListTile({
    required this.assist,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final numberOfAssists = assist?.statistics?.fold(0, (sum, statistic) => sum + (statistic.goals?.assists ?? 0));

    if ((numberOfAssists ?? 0) > 0) {
      return BalunButton(
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
                  imageUrl: assist?.player?.photo ?? BalunIcons.placeholderPlayer,
                  height: 48,
                  width: 48,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (assist?.player?.name != null)
                    Text(
                      mixOrOriginalWords(assist!.player!.name) ?? '---',
                      style: context.textStyles.leagueTeamsTitle,
                    ),
                  Text(
                    '$numberOfAssists ${'leagueTopAssistsNumber'.tr()}',
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
