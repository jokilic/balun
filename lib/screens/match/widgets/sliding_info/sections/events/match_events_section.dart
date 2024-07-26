import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/event/event.dart';
import 'match_events_list_tile.dart';

class MatchEventsSection extends StatelessWidget {
  final List<Event>? events;

  const MatchEventsSection({
    required this.events,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: (events?.isNotEmpty ?? false)
              ? events!
                  .map(
                    (event) => MatchEventsListTile(
                      event: event,
                    ),
                  )
                  .toList()
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
