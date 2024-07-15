import 'fixture_periods.dart';
import 'fixture_status.dart';
import 'fixture_venue.dart';

class Fixture {
  final int? id;
  final String? referee;
  final String? timezone;
  final DateTime? date;
  final DateTime? timestamp;
  final FixturePeriods? periods;
  final FixtureVenue? venue;
  final FixtureStatus? status;

  Fixture({
    this.id,
    this.referee,
    this.timezone,
    this.date,
    this.timestamp,
    this.periods,
    this.venue,
    this.status,
  });

  factory Fixture.fromMap(Map<String, dynamic> map) => Fixture(
        id: map['id'] != null ? map['id'] as int : null,
        referee: map['referee'] != null ? map['referee'] as String : null,
        timezone: map['timezone'] != null ? map['timezone'] as String : null,
        date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
        timestamp: map['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int) : null,
        periods: map['periods'] != null ? FixturePeriods.fromMap(map['periods'] as Map<String, dynamic>) : null,
        venue: map['venue'] != null ? FixtureVenue.fromMap(map['venue'] as Map<String, dynamic>) : null,
        status: map['status'] != null ? FixtureStatus.fromMap(map['status'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'Fixture(id: $id, referee: $referee, timezone: $timezone, date: $date, timestamp: $timestamp, periods: $periods, venue: $venue, status: $status)';

  @override
  bool operator ==(covariant Fixture other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id &&
        other.referee == referee &&
        other.timezone == timezone &&
        other.date == date &&
        other.timestamp == timestamp &&
        other.periods == periods &&
        other.venue == venue &&
        other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ referee.hashCode ^ timezone.hashCode ^ date.hashCode ^ timestamp.hashCode ^ periods.hashCode ^ venue.hashCode ^ status.hashCode;
}
