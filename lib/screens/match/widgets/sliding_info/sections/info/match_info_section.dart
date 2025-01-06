import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture/fixture_status.dart';
import '../../../../../../models/fixtures/fixture/fixture_venue.dart';
import '../../../../../../models/fixtures/league/league.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class MatchInfoSection extends StatelessWidget {
  final DateTime? timestamp;
  final String? referee;
  final FixtureVenue? venue;
  final FixtureStatus? status;
  final League? league;

  const MatchInfoSection({
    required this.timestamp,
    required this.referee,
    required this.venue,
    required this.status,
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    final matchDateTime = parseTimestamp(timestamp);
    final matchDateTimeAgo = parseDateTimeago(
      timestamp,
      context: context,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          ///
          /// DATE
          ///
          if (matchDateTime != null) ...[
            Row(
              children: [
                const BalunImage(
                  imageUrl: BalunIcons.matchDateTime,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'matchInfoTime'.tr(),
                        style: context.textStyles.matchInfoSectionTitle,
                      ),
                      Text(
                        DateFormat(
                          'd. MMMM y. - HH:mm',
                          context.locale.toLanguageTag(),
                        ).format(matchDateTime),
                        style: context.textStyles.matchInfoSectionText,
                      ),
                      const SizedBox(height: 2),
                      if (matchDateTimeAgo != null)
                        Text(
                          matchDateTimeAgo,
                          style: context.textStyles.matchInfoSectionBottomText,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],

          ///
          /// MATCH STATUS
          ///
          if (status != null) ...[
            Row(
              children: [
                const BalunImage(
                  imageUrl: BalunIcons.matchStatus,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'matchInfoStatus'.tr(),
                        style: context.textStyles.matchInfoSectionTitle,
                      ),
                      Text(
                        getMatchStatusLong(status!.short ?? ''),
                        style: context.textStyles.matchInfoSectionText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],

          ///
          /// LEAGUE
          ///
          if (league?.id != null) ...[
            BalunButton(
              onPressed: league?.id != null
                  ? () => openLeague(
                        context,
                        leagueId: league!.id!,
                        season: league?.season ?? getCurrentSeasonYear().toString(),
                      )
                  : null,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    if (league?.logo != null)
                      BalunImage(
                        imageUrl: league!.logo!,
                        height: 52,
                        width: 52,
                      )
                    else
                      const BalunImage(
                        imageUrl: BalunIcons.matchLeague,
                        height: 52,
                        width: 52,
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'matchInfoLeague'.tr(),
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          if (league?.name != null) ...[
                            Text(
                              mixOrOriginalWords(league!.name) ?? '---',
                              style: context.textStyles.matchInfoSectionText,
                            ),
                            const SizedBox(height: 2),
                          ],
                          if (league?.country != null)
                            Text(
                              mixOrOriginalWords(league!.country) ?? '---',
                              style: context.textStyles.matchInfoSectionBottomText,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],

          ///
          /// ROUND
          ///
          if (league?.id != null) ...[
            BalunButton(
              onPressed: league?.id != null
                  ? () => openLeague(
                        context,
                        leagueId: league!.id!,
                        season: league?.season ?? getCurrentSeasonYear().toString(),
                      )
                  : null,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    const BalunImage(
                      imageUrl: BalunIcons.matchRound,
                      height: 52,
                      width: 52,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'matchInfoRound'.tr(),
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          if (league?.round != null) ...[
                            Text(
                              league!.round!,
                              style: context.textStyles.matchInfoSectionText,
                            ),
                            const SizedBox(height: 2),
                          ],
                          if (league?.season != null)
                            Text(
                              '${'matchInfoSeason'.tr()} ${league!.season!}',
                              style: context.textStyles.matchInfoSectionBottomText,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],

          ///
          /// REFEREE
          ///
          if (referee?.isNotEmpty ?? false) ...[
            Row(
              children: [
                const BalunImage(
                  imageUrl: BalunIcons.referee,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'matchInfoReferee'.tr(),
                        style: context.textStyles.matchInfoSectionTitle,
                      ),
                      Text(
                        mixOrOriginalWords(referee) ?? '---',
                        style: context.textStyles.matchInfoSectionText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],

          ///
          /// STADIUM
          ///
          if (venue?.id != null) ...[
            Row(
              children: [
                const BalunImage(
                  imageUrl: BalunIcons.matchVenue,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'matchInfoVenue'.tr(),
                        style: context.textStyles.matchInfoSectionTitle,
                      ),
                      if (venue?.name != null) ...[
                        Text(
                          mixOrOriginalWords(venue!.name) ?? '---',
                          style: context.textStyles.matchInfoSectionText,
                        ),
                        const SizedBox(height: 2),
                      ],
                      if (venue?.city != null)
                        Text(
                          mixOrOriginalWords(venue!.city) ?? '---',
                          style: context.textStyles.matchInfoSectionBottomText,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
