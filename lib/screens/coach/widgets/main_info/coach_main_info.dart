import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/coaches/coach_response.dart';
import '../../../../routing.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/date_time.dart';
import '../../../../util/string.dart';
import '../../../../util/word_mix.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';
import '../coach_app_bar.dart';

class CoachMainInfo extends WatchingWidget {
  final CoachResponse coach;

  const CoachMainInfo({
    required this.coach,
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
            const SizedBox(height: 12),

            ///
            /// BACK & LEAGUE
            ///
            CoachAppBar(
              onPressed: Navigator.of(context).pop,
              coach: coach,
            ),

            const SizedBox(height: 48),

            ///
            /// LOGO
            ///
            BalunImage(
              imageUrl: coach.photo ?? BalunIcons.placeholderPlayer,
              height: 120,
              width: 120,
            ),

            const SizedBox(height: 16),

            ///
            /// NAME
            ///
            Text(
              '${mixOrOriginalWords(coach.firstName) ?? '--'} ${mixOrOriginalWords(coach.lastName) ?? '--'}',
              style: context.textStyles.leagueName,
              textAlign: TextAlign.center,
            ),

            ///
            /// COUNTRY
            ///
            Text(
              coach.nationality != null
                  ? mixOrOriginalWords(
                        getCountryName(
                          country: coach.nationality!,
                        ),
                      ) ??
                      '---'
                  : '---',
              style: context.textStyles.leagueCountry,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            ///
            /// TEAM
            ///
            if (coach.team != null)
              BalunButton(
                onPressed: coach.team?.id != null
                    ? () => openTeam(
                          context,
                          teamId: coach.team!.id!,
                          season: getCurrentSeasonYear().toString(),
                        )
                    : null,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BalunImage(
                        imageUrl: coach.team?.logo ?? BalunIcons.placeholderTeam,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          mixOrOriginalWords(coach.team?.name) ?? '---',
                          style: context.textStyles.leagueCountry,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
}
