import '../models/fixtures/event/event.dart';
import '../models/fixtures/event/event_time.dart';
import '../models/fixtures/score/score.dart';

List<Event>? getEventsList({
  required List<Event>? events,
  required Score? score,
}) {
  if ((events?.isEmpty ?? false) && score == null) {
    return null;
  }

  final eventsScores = List<Event>.from(events ?? []).toList();

  if (score?.halftime?.home != null && score?.halftime?.away != null) {
    eventsScores.add(
      Event(
        type: 'halftime',
        detail: '${score?.halftime?.home}:${score?.halftime?.away}',
        time: EventTime(elapsed: 45),
      ),
    );
  }

  if (score?.fulltime?.home != null && score?.fulltime?.away != null) {
    eventsScores.add(
      Event(
        type: 'fulltime',
        detail: '${score?.fulltime?.home}:${score?.fulltime?.away}',
        time: EventTime(elapsed: 1001),
      ),
    );
  }

  if (score?.extratime?.home != null && score?.extratime?.away != null) {
    eventsScores.add(
      Event(
        type: 'extratime',
        detail: '${score?.extratime?.home}:${score?.extratime?.away}',
        time: EventTime(elapsed: 1002),
      ),
    );
  }

  if (score?.penalty?.home != null && score?.extratime?.away != null) {
    eventsScores.add(
      Event(
        type: 'penalty',
        detail: '${score?.penalty?.home}:${score?.penalty?.away}',
        time: EventTime(elapsed: 1003),
      ),
    );
  }

  eventsScores.sort(
    (a, b) {
      final aTime = (a.time?.elapsed ?? 0) + (a.time?.extra ?? 0);
      final bTime = (b.time?.elapsed ?? 0) + (b.time?.extra ?? 0);

      return aTime.compareTo(bTime);
    },
  );

  return eventsScores;
}
