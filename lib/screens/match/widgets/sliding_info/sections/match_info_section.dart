import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../models/fixtures/fixture/fixture_status.dart';
import '../../../../../models/fixtures/fixture/fixture_venue.dart';
import '../../../../../routing.dart';
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
                const Icon(
                  Icons.punch_clock_rounded,
                  size: 48,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

          const SizedBox(height: 16),

          ///
          /// MATCH STATUS
          ///
          if (status != null)
            Row(
              children: [
                const Icon(
                  Icons.sports_soccer_rounded,
                  size: 48,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    status!.long ?? status!.short ?? 'Nothing',
                    style: context.textStyles.matchInfoSectionText,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 16),

          ///
          /// REFEREE
          ///
          if (referee != null)
            Row(
              children: [
                const Icon(
                  Icons.refresh_rounded,
                  size: 48,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    referee!,
                    style: context.textStyles.matchInfoSectionText,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 16),

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
                  const Icon(
                    Icons.stadium_rounded,
                    size: 48,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
