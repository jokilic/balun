import 'package:flutter/material.dart';

import '../../../../../../models/trophies/trophy_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';

class PlayerTrophiesListTile extends StatelessWidget {
  final TrophyResponse trophy;

  const PlayerTrophiesListTile({
    required this.trophy,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// PLACE
            ///
            if (trophy.place != null) ...[
              Text(
                trophy.place!,
                style: context.textStyles.titleMdBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            ///
            /// SEASON
            ///
            if (trophy.season != null) ...[
              Text(
                trophy.season!,
                style: context.textStyles.bodyMdBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            ///
            /// LEAGUE
            ///
            if (trophy.league != null) ...[
              Text(
                mixOrOriginalWords(trophy.league) ?? '---',
                style: context.textStyles.bodyMdBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            ///
            /// COUNTRY
            ///
            if (trophy.country != null) ...[
              Text(
                mixOrOriginalWords(
                      getCountryName(
                        country: trophy.country!,
                      ),
                    ) ??
                    '---',
                style: context.textStyles.bodyMdLightMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      );
}
