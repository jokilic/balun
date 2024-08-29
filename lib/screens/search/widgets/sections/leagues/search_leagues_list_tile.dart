import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../../../models/search/search_leagues/search_league_response.dart';
import '../../../../../theme/icons.dart';

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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: league.league?.logo != null
                    ? BalunImage(
                        imageUrl: league.league!.logo!,
                        height: 48,
                        width: 48,
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        color: context.colors.white.withOpacity(0.5),
                        child: Image.asset(
                          BalunIcons.placeholderLeague,
                          height: 32,
                          width: 44,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      league.league?.name ?? 'Unknown',
                      style: context.textStyles.fixturesCountry,
                    ),
                    if (league.league?.type != null)
                      Text(
                        league.league!.type!,
                        style: context.textStyles.leagueSeason,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
