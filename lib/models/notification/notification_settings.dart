import 'package:hive_ce/hive.dart';

part 'notification_settings.g.dart';

@HiveType(typeId: 5)
class NotificationSettings {
  @HiveField(0)
  final bool showLeagueNotifications;
  @HiveField(1)
  final bool showTeamNotifications;

  NotificationSettings({
    required this.showLeagueNotifications,
    required this.showTeamNotifications,
  });

  @override
  String toString() => 'NotificationSettings(showLeagueNotifications: $showLeagueNotifications, showTeamNotifications: $showTeamNotifications)';

  @override
  bool operator ==(covariant NotificationSettings other) {
    if (identical(this, other)) {
      return true;
    }

    return other.showLeagueNotifications == showLeagueNotifications && other.showTeamNotifications == showTeamNotifications;
  }

  @override
  int get hashCode => showLeagueNotifications.hashCode ^ showTeamNotifications.hashCode;
}
