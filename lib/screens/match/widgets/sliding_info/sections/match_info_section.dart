import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../models/fixtures/fixture/fixture_status.dart';
import '../../../../../models/fixtures/fixture/fixture_venue.dart';
import '../../../../../routing.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/date_time.dart';
import '../../../../../widgets/balun_button.dart';

class MatchInfoSection extends StatelessWidget {
  final DateTime? timestamp;
  final String? referee;
  final FixtureVenue? venue;
  final FixtureStatus? status;

  const MatchInfoSection({
    this.timestamp,
    this.referee,
    this.venue,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    final matchDateTime = parseTimestamp(timestamp);

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
          if (matchDateTime != null)
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
                        DateFormat('d. MMMM y.').format(matchDateTime),
                        style: context.textStyles.matchInfoSectionText,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('HH:mm').format(matchDateTime),
                        style: context.textStyles.matchInfoSectionText,
                      ),
                    ],
                  ),
                ),
              ],
            ),

          const SizedBox(height: 24),

          ///
          /// MATCH STATUS
          ///
          if (status != null)
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
                        status!.long ?? status!.short ?? 'Nothing',
                        style: context.textStyles.matchInfoSectionText,
                      ),
                    ],
                  ),
                ),
              ],
            ),

          const SizedBox(height: 24),

          ///
          /// REFEREE
          ///
          if (referee != null)
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

          ///
          /// STADIUM
          ///
          if (venue != null)
            BalunButton(
              onPressed: venue?.id != null
                  ? () => openVenue(
                        context,
                        venueId: venue!.id!,
                      )
                  : null,
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
        ],
      ),
    );
  }
}
