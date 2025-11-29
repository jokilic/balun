import 'package:hive_ce/hive.dart';

part 'notification_settings.g.dart';

@HiveType(typeId: 5)
class NotificationSettings {
  @HiveField(0)
  final bool showLeagueNotifications;
  @HiveField(1)
  final bool showTeamNotifications;
  @HiveField(2)
  final bool showMatchNotifications;

  NotificationSettings({
    required this.showLeagueNotifications,
    required this.showTeamNotifications,
    required this.showMatchNotifications,
  });

  @override
  String toString() =>
      'NotificationSettings(showLeagueNotifications: $showLeagueNotifications, showTeamNotifications: $showTeamNotifications, showMatchNotifications: $showMatchNotifications)';

  @override
  bool operator ==(covariant NotificationSettings other) {
    if (identical(this, other)) {
      return true;
    }

    return other.showLeagueNotifications == showLeagueNotifications &&
        other.showTeamNotifications == showTeamNotifications &&
        other.showMatchNotifications == showMatchNotifications;
  }

  @override
  int get hashCode => showLeagueNotifications.hashCode ^ showTeamNotifications.hashCode ^ showMatchNotifications.hashCode;
}
