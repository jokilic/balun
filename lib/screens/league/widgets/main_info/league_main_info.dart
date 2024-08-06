import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/leagues/league_response.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';
import '../league_app_bar.dart';

class LeagueMainInfo extends StatelessWidget {
  final LeagueResponse league;

  const LeagueMainInfo({
    required this.league,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            /// BACK & LEAGUE
            ///
            LeagueAppBar(
              onPressed: Navigator.of(context).pop,
              league: league.league!,
            ),

            const SizedBox(height: 48),

            ///
            /// INFO
            ///
            BalunButton(
              onPressed: () {},
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    ///
                    /// LOGO
                    ///
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: BalunImage(
                        imageUrl: league.league?.logo ?? BalunImages.placeholderLogo,
                        height: 120,
                        width: 120,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ///
                    /// NAME
                    ///
                    Text(
                      league.league?.name ?? 'No name',
                      style: context.textStyles.leagueName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),

                    ///
                    /// COUNTRY
                    ///
                    Text(
                      league.country?.name ?? 'No name',
                      style: context.textStyles.fixturesName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
