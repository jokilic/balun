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
  @HiveField(3)
  final bool playNotificationSound;

  NotificationSettings({
    required this.showLeagueNotifications,
    required this.showTeamNotifications,
    required this.showMatchNotifications,
    required this.playNotificationSound,
  });

  @override
  String toString() =>
      'NotificationSettings(showLeagueNotifications: $showLeagueNotifications, showTeamNotifications: $showTeamNotifications, showMatchNotifications: $showMatchNotifications, playNotificationSound: $playNotificationSound)';

  @override
  bool operator ==(covariant NotificationSettings other) {
    if (identical(this, other)) {
      return true;
    }

    return other.showLeagueNotifications == showLeagueNotifications &&
        other.showTeamNotifications == showTeamNotifications &&
        other.showMatchNotifications == showMatchNotifications &&
        other.playNotificationSound == playNotificationSound;
  }

  @override
  int get hashCode => showLeagueNotifications.hashCode ^ showTeamNotifications.hashCode ^ showMatchNotifications.hashCode ^ playNotificationSound.hashCode;
}
