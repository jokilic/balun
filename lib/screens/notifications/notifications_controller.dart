import 'package:flutter/material.dart';

import '../../models/notification/notification_settings.dart';
import '../../services/background_fetch_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/notification_service.dart';

class NotificationsController extends ValueNotifier<NotificationSettings> {
  final LoggerService logger;
  final HiveService hive;
  final NotificationService notification;
  final BackgroundFetchService backgroundFetch;

  NotificationsController({
    required this.logger,
    required this.hive,
    required this.notification,
    required this.backgroundFetch,
  }) : super(hive.getNotificationSettings());

  ///
  /// METHODS
  ///

  Future<void> onPressedFavoriteLeagues() async {
    await updateState(
      newNotificationSettings: NotificationSettings(
        showLeagueNotifications: !value.showLeagueNotifications,
        showTeamNotifications: value.showTeamNotifications,
        showMatchNotifications: value.showMatchNotifications,
      ),
    );

    /// Initialize notifications if necessary
    await notification.init();

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedFavoriteTeams() async {
    await updateState(
      newNotificationSettings: NotificationSettings(
        showLeagueNotifications: value.showLeagueNotifications,
        showTeamNotifications: !value.showTeamNotifications,
        showMatchNotifications: value.showMatchNotifications,
      ),
    );

    /// Initialize notifications if necessary
    await notification.init();

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedFavoriteMatches() async {
    await updateState(
      newNotificationSettings: NotificationSettings(
        showLeagueNotifications: value.showLeagueNotifications,
        showTeamNotifications: value.showTeamNotifications,
        showMatchNotifications: !value.showMatchNotifications,
      ),
    );

    /// Initialize notifications if necessary
    await notification.init();

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  void testNotification() => notification.testNotification();

  Future<void> updateState({
    required NotificationSettings newNotificationSettings,
  }) async {
    value = newNotificationSettings;
    await hive.writeNotificationSettings(newNotificationSettings);
  }
}
