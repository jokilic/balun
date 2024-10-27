import '../models/fixtures/event/event.dart';
import '../models/fixtures/score/score.dart';

List<Event> calculatedCardsEvents(List<Event>? events) {
  final playerYellowCards = <String, List<Event>>{};
  final processedEvents = <Event>[];

  for (final event in events ?? []) {
    final playerKey = '${event.team?.id}-${event.player?.id}';

    if (event.detail?.toLowerCase() == 'yellow card') {
      playerYellowCards[playerKey] = (playerYellowCards[playerKey] ?? [])..add(event);
      processedEvents.add(event);
    } else if (event.detail?.toLowerCase() == 'red card') {
      /// This is likely a red card due to second yellow, so we skip it
      if (playerYellowCards[playerKey]?.isNotEmpty ?? false) {
        continue;
      }

      /// This is a direct red card, so we keep it
      else {
        processedEvents.add(event);
      }
    }

    /// For all other events, we just add them to the processed list
    else {
      processedEvents.add(event);
    }
  }

  return processedEvents;
}

bool isSecondYellowCard(List<Event> events, Event currentEvent) {
  if (currentEvent.detail?.toLowerCase() != 'yellow card') {
    return false;
  }

  final playerKey = '${currentEvent.team?.id}-${currentEvent.player?.id}';

  final yellowCardCount = events
      .where(
        (event) => '${event.team?.id}-${event.player?.id}' == playerKey && event.detail?.toLowerCase() == 'yellow card' && events.indexOf(event) <= events.indexOf(currentEvent),
      )
      .length;

  return yellowCardCount == 2;
}
