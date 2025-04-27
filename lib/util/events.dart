import '../models/fixtures/event/event.dart';

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

/// Return player key which is used to check if player got a second yellow card
String? getPlayerKey(Event event) {
  final teamId = event.team?.id;
  final player = event.player;

  if (teamId == null || player == null) {
    return null;
  }

  final identifier = player.id?.toString() ?? player.name?.toLowerCase().trim();

  if (identifier == null || identifier.isEmpty) {
    return null;
  }

  return '$teamId-$identifier';
}

/// Check if some player has received a second yellow card
bool isSecondYellowCard(List<Event> events, Event currentEvent) {
  /// Check only yellow‐card events
  if (currentEvent.detail?.toLowerCase() != 'yellow card') {
    return false;
  }

  final key = getPlayerKey(currentEvent);

  if (key == null) {
    return false;
  }

  var count = 0;
  for (final e in events) {
    if (e.detail?.toLowerCase() == 'yellow card' && getPlayerKey(e) == key) {
      count++;
    }

    /// stop counting once we've reached the current event
    if (identical(e, currentEvent)) {
      break;
    }
  }

  return count == 2;
}
