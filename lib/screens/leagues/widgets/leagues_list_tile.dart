import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../models/leagues/league_response.dart';
import '../../../theme/icons.dart';

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
                        child: const BalunImage(
                          imageUrl: BalunIcons.countryPlaceholder,
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
                    if (league.league?.name != null)
                      Text(
                        league.league!.name!,
                        style: context.textStyles.fixturesCountry,
                      ),
                    if (league.league?.type != null)
                      Text(
                        league.league!.type!,
                        style: context.textStyles.fixturesLeague.copyWith(
                          color: context.colors.black.withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
