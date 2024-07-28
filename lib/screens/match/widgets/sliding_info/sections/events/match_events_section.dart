import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/event/event.dart';
import '../../../../../../theme/theme.dart';
import 'match_events_list_tile.dart';

class MatchEventsSection extends StatelessWidget {
  final List<Event>? eventsScoresList;
  final int? awayTeamId;

  const MatchEventsSection({
    required this.eventsScoresList,
    required this.awayTeamId,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: (eventsScoresList?.isNotEmpty ?? false)
              ? [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          'Match started',
                          style: context.textStyles.matchEventsSectionResult,
                        ),
                      ],
                    ),
                  ),
                  ...eventsScoresList!
                      .map(
                        (event) => MatchEventsListTile(
                          event: event,
                          isAwayTeam: event.team?.id == awayTeamId,
                        ),
                      )
                      .toList(),
                ]
              : [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.blueGrey,
                  ),
                ],
        ),
      );
}
