import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../models/leagues/league_response.dart';
import '../../../theme/icons.dart';
import '../../../util/string.dart';

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
                borderRadius: BorderRadius.circular(100),
                child: league.league?.logo != null
                    ? BalunImage(
                        imageUrl: league.league!.logo!,
                        height: 40,
                        width: 40,
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        color: context.colors.white,
                        child: const BalunImage(
                          imageUrl: BalunIcons.countryPlaceholder,
                          height: 28,
                          width: 28,
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
