import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/fixtures/fixture/fixture_status.dart';
import '../../../../../../models/fixtures/fixture/fixture_venue.dart';
import '../../../../../../models/fixtures/league/league.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/string.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

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
    final matchDateTimeAgo = parseDateTimeago(timestamp);

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
                Image.asset(
                  BalunIcons.matchDateTime,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time',
                        style: context.textStyles.matchInfoSectionTitle,
                      ),
                      Text(
                        DateFormat('d. MMMM y. - HH:mm').format(matchDateTime),
                        style: context.textStyles.matchInfoSectionText,
                      ),
                      const SizedBox(height: 2),
                      if (matchDateTimeAgo != null)
                        Text(
                          matchDateTimeAgo,
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
          /// MATCH STATUS
          ///
          if (status != null) ...[
            Row(
              children: [
                Image.asset(
                  BalunIcons.matchStatus,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: context.textStyles.matchInfoSectionTitle,
                      ),
                      Text(
                        getMatchStatus(status!.short ?? ''),
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
                        season: league?.season ?? DateTime.now().year,
                      )
                  : null,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    if (league?.logo != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BalunImage(
                          imageUrl: league!.logo!,
                          height: 52,
                          width: 52,
                        ),
                      )
                    else
                      Image.asset(
                        BalunIcons.matchLeague,
                        height: 52,
                        width: 52,
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'League',
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          if (league?.name != null) ...[
                            Text(
                              league!.name!,
                              style: context.textStyles.matchInfoSectionText,
                            ),
                            const SizedBox(height: 2),
                          ],
                          if (league?.country != null)
                            Text(
                              league!.country!,
                              style: context.textStyles.matchInfoSectionText,
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
                        season: league?.season ?? DateTime.now().year,
                      )
                  : null,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Image.asset(
                      BalunIcons.matchRound,
                      height: 52,
                      width: 52,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Round',
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
                              'Season ${league!.season!}',
                              style: context.textStyles.matchInfoSectionText,
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
                Image.asset(
                  BalunIcons.referee,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Referee',
                        style: context.textStyles.matchInfoSectionTitle,
                      ),
                      Text(
                        referee!,
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
            BalunButton(
              onPressed: venue?.id != null
                  ? () => openVenue(
                        context,
                        venueId: venue!.id!,
                      )
                  : null,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Image.asset(
                      BalunIcons.matchVenue,
                      height: 52,
                      width: 52,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Venue',
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          if (venue?.name != null) ...[
                            Text(
                              venue!.name!,
                              style: context.textStyles.matchInfoSectionText,
                            ),
                            const SizedBox(height: 2),
                          ],
                          if (venue?.city != null)
                            Text(
                              venue!.city!,
                              style: context.textStyles.matchInfoSectionText,
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
        ],
      ),
    );
  }
}
