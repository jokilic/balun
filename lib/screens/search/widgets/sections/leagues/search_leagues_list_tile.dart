import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../models/search/search_leagues/search_league_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../util/string.dart';
import '../../../../../util/word_mix.dart';
import '../../../../../widgets/balun_image.dart';

class SearchLeaguesListTile extends StatelessWidget {
  final SearchLeagueResponse league;
  final Function()? leaguePressed;

  const SearchLeaguesListTile({
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
                imageUrl: BalunIcons.placeholderLeague,
                height: 28,
                width: 28,
              ),
            ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mixOrOriginalWords(league.league?.name) ?? '---',
                  style: context.textStyles.bodyLgBold,
                ),
                if (league.league?.type != null)
                  Text(
                    getLeagueType(
                      leagueType: league.league!.type!,
                    ),
                    style: context.textStyles.labelMediumMuted,
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
