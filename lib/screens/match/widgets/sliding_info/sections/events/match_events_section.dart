import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/event/event.dart';
import '../../../../../../models/fixtures/score/score.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/events.dart';
import '../../../../../../widgets/balun_empty.dart';
import 'match_events_list_tile.dart';

class MatchEventsSection extends StatelessWidget {
  final List<Event>? events;
  final Score? score;
  final int? elapsed;
  final int? awayTeamId;
  final String statusShort;
  final String? season;

  const MatchEventsSection({
    required this.events,
    required this.score,
    required this.elapsed,
    required this.awayTeamId,
    required this.statusShort,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    /// First half events
    final firstHalfEvents = events?.where(
      (event) => (event.time?.elapsed ?? 999) <= 45,
    );

    /// Second half events
    final secondHalfEvents = events?.where(
      (event) => (event.time?.elapsed ?? 0) > 45 && (event.time?.elapsed ?? 999) <= 90,
    );

    /// First extra-time events
    final firstExtraTimeEvents = events?.where(
      (event) => (event.time?.elapsed ?? 0) > 90 && (event.time?.elapsed ?? 999) <= 105,
    );

    /// Second extra-time events
    final secondExtraTimeEvents = events?.where(
      (event) => (event.time?.elapsed ?? 0) > 105 && (event.time?.elapsed ?? 999) <= 120,
    );

    /// Penalty events
    final penaltyEvents = events?.where(
      (event) => (event.time?.elapsed ?? 0) > 120,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: ((events?.isEmpty ?? true) && elapsed == null)
            ? [
                BalunEmpty(
                  message: 'matchEventsNo'.tr(),
                  isSmall: true,
                ),
              ]
            : [
                ///
                /// MATCH STARTED
                ///
                if (elapsed != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'matchEventsStarted'.tr(),
                            style: context.textStyles.matchEventsSectionResult,
                          ),
                        ),
                      ],
                    ),
                  ),

                ///
                /// FIRST HALF EVENTS
                ///
                ...firstHalfEvents!
                    .map(
                      (event) => MatchEventsListTile(
                        event: event,
                        isAwayTeam: event.team?.id == awayTeamId,
                        isSecondYellowCard: isSecondYellowCard(
                          events ?? [],
                          event,
                        ),
                        season: season,
                      ),
                    )
                    .toList(),

                ///
                /// SECOND HALF
                ///
                if ((score?.halftime?.home != null && score?.halftime?.away != null) && (elapsed ?? 0) >= 45 && statusShort != '1H')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'matchEvents1stHalf'.tr(),
                            style: context.textStyles.matchEventsSectionResult,
                          ),
                        ),
                        Text(
                          '${score!.halftime!.home}:${score!.halftime!.away}',
                          style: context.textStyles.matchEventsSectionResult,
                        ),
                      ],
                    ),
                  ),

                ///
                /// SECOND HALF EVENTS
                ///
                ...secondHalfEvents!
                    .map(
                      (event) => MatchEventsListTile(
                        event: event,
                        isAwayTeam: event.team?.id == awayTeamId,
                        isSecondYellowCard: isSecondYellowCard(
                          events ?? [],
                          event,
                        ),
                        season: season,
                      ),
                    )
                    .toList(),

                ///
                /// REGULAR TIME ENDED
                ///
                if ((score?.fulltime?.home != null && score?.fulltime?.away != null) && (elapsed ?? 0) >= 90 && statusShort != '1H' && statusShort != 'HT' && statusShort != '2H')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            score?.extratime?.home == null && score?.extratime?.away == null ? 'matchEventsFullTime'.tr() : 'matchEventsFullTimeRegularTime'.tr(),
                            style: context.textStyles.matchEventsSectionResult,
                          ),
                        ),
                        Text(
                          '${score!.fulltime!.home}:${score!.fulltime!.away}',
                          style: context.textStyles.matchEventsSectionResult,
                        ),
                      ],
                    ),
                  ),

                ///
                /// FIRST EXTRA TIME EVENTS
                ///
                ...firstExtraTimeEvents!
                    .map(
                      (event) => MatchEventsListTile(
                        event: event,
                        isAwayTeam: event.team?.id == awayTeamId,
                        isSecondYellowCard: isSecondYellowCard(
                          events ?? [],
                          event,
                        ),
                        season: season,
                      ),
                    )
                    .toList(),

                ///
                /// SECOND EXTRA TIME EVENTS
                ///
                ...secondExtraTimeEvents!
                    .map(
                      (event) => MatchEventsListTile(
                        event: event,
                        isAwayTeam: event.team?.id == awayTeamId,
                        isSecondYellowCard: isSecondYellowCard(
                          events ?? [],
                          event,
                        ),
                        season: season,
                      ),
                    )
                    .toList(),

                ///
                /// EXTRA TIME ENDED
                ///
                if ((score?.extratime?.home != null && score?.extratime?.away != null) &&
                    (elapsed ?? 0) >= 120 &&
                    statusShort != '1H' &&
                    statusShort != 'HT' &&
                    statusShort != '2H' &&
                    statusShort != 'ET' &&
                    statusShort != 'BT')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'matchEventsExtraTime'.tr(),
                            style: context.textStyles.matchEventsSectionResult,
                          ),
                        ),
                        Text(
                          '${score!.extratime!.home}:${score!.extratime!.away}',
                          style: context.textStyles.matchEventsSectionResult,
                        ),
                      ],
                    ),
                  ),

                ///
                /// PENALTY EVENTS
                ///
                ...penaltyEvents!
                    .map(
                      (event) => MatchEventsListTile(
                        event: event,
                        isAwayTeam: event.team?.id == awayTeamId,
                        isSecondYellowCard: isSecondYellowCard(
                          events ?? [],
                          event,
                        ),
                        season: season,
                      ),
                    )
                    .toList(),

                ///
                /// PENALTIES ENDED
                ///
                if ((score?.penalty?.home != null && score?.penalty?.away != null) &&
                    (elapsed ?? 0) >= 120 &&
                    statusShort != '1H' &&
                    statusShort != 'HT' &&
                    statusShort != '2H' &&
                    statusShort != 'ET' &&
                    statusShort != 'BT' &&
                    statusShort != 'P')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'matchEventsPenalties'.tr(),
                            style: context.textStyles.matchEventsSectionResult,
                          ),
                        ),
                        Text(
                          '${score!.penalty!.home}:${score!.penalty!.away}',
                          style: context.textStyles.matchEventsSectionResult,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),
              ],
      ),
    );
  }
}
