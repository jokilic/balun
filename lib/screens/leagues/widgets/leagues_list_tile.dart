import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../models/leagues/league_response.dart';
import '../../../theme/icons.dart';
import '../../../util/string.dart';
import '../../../util/word_mix.dart';
import '../../../widgets/balun_image/balun_image.dart';

class LeaguesListTile extends StatelessWidget {
  final LeagueResponse league;
  final Function()? leaguePressed;

  const LeaguesListTile({
    required this.league,
    required this.leaguePressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
    onPressed: leaguePressed,
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          if (league.league?.logo != null)
            BalunImage(
              imageUrl: league.league!.logo!,
              height: 40,
              width: 40,
            )
          else
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: context.colors.primaryBackground,
              ),
              child: const BalunImage(
                imageUrl: BalunIcons.placeholderCountry,
                height: 28,
                width: 28,
              ),
            ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (league.league?.name != null)
                  Text(
                    mixOrOriginalWords(league.league!.name) ?? '---',
                    style: context.textStyles.fixturesLeague,
                  ),
                if (league.league?.type != null)
                  Text(
                    getLeagueType(
                      leagueType: league.league!.type!,
                    ),
                    style: context.textStyles.leaguesSubtitle,
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
