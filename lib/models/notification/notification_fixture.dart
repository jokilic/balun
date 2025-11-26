import 'package:hive_ce/hive.dart';

part 'notification_fixture.g.dart';

@HiveType(typeId: 0)
class NotificationFixture {
  @HiveField(0)
  final int? fixtureId;

  @HiveField(1)
  final String? homeName;
  @HiveField(2)
  final String? awayName;

  @HiveField(3)
  final int? homeGoals;
  @HiveField(4)
  final int? awayGoals;

  @HiveField(5)
  final String? statusShort;

  @HiveField(6)
  final bool? halfTimeNotified;
  @HiveField(7)
  final bool? extraTimeNotified;
  @HiveField(8)
  final bool? penaltiesNotified;
  @HiveField(9)
  final bool? fullTimeNotified;

  @HiveField(10)
  final int? lastNotifiedTotalGoals;

  NotificationFixture({
    required this.fixtureId,
    required this.homeName,
    required this.awayName,
    required this.homeGoals,
    required this.awayGoals,
    required this.statusShort,
    required this.halfTimeNotified,
    required this.extraTimeNotified,
    required this.penaltiesNotified,
    required this.fullTimeNotified,
    required this.lastNotifiedTotalGoals,
  });

  @override
  String toString() =>
      'NotificationFixture(fixtureId: $fixtureId, homeName: $homeName, awayName: $awayName,   homeGoals: $homeGoals, awayGoals: $awayGoals, statusShort: $statusShort, halfTimeNotified: $halfTimeNotified, extraTimeNotified: $extraTimeNotified, penaltiesNotified: $penaltiesNotified, fullTimeNotified: $fullTimeNotified, lastNotifiedTotalGoals: $lastNotifiedTotalGoals)';

  @override
  bool operator ==(covariant NotificationFixture other) {
    if (identical(this, other)) {
      return true;
    }

    return other.fixtureId == fixtureId &&
        other.homeName == homeName &&
        other.awayName == awayName &&
        other.homeGoals == homeGoals &&
        other.awayGoals == awayGoals &&
        other.statusShort == statusShort &&
        other.halfTimeNotified == halfTimeNotified &&
        other.extraTimeNotified == extraTimeNotified &&
        other.penaltiesNotified == penaltiesNotified &&
        other.fullTimeNotified == fullTimeNotified &&
        other.lastNotifiedTotalGoals == lastNotifiedTotalGoals;
  }

  @override
  int get hashCode =>
      fixtureId.hashCode ^
      homeName.hashCode ^
      awayName.hashCode ^
      homeGoals.hashCode ^
      awayGoals.hashCode ^
      statusShort.hashCode ^
      halfTimeNotified.hashCode ^
      extraTimeNotified.hashCode ^
      penaltiesNotified.hashCode ^
      fullTimeNotified.hashCode ^
      lastNotifiedTotalGoals.hashCode;
}
