import 'package:flutter/material.dart';

import '../../models/notification/notification_settings.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/notification_service.dart';

class NotificationsController extends ValueNotifier<NotificationSettings> {
  final LoggerService logger;
  final HiveService hive;
  final NotificationService notification;

  NotificationsController({
    required this.logger,
    required this.hive,
    required this.notification,
  }) : super(hive.getNotificationSettings());

  ///
  /// METHODS
  ///

  void onPressedFavoriteLeagues() => updateState(
    newNotificationSettings: NotificationSettings(
      showLeagueNotifications: !value.showLeagueNotifications,
      showTeamNotifications: value.showTeamNotifications,
    ),
  );

  void onPressedFavoriteTeams() => updateState(
    newNotificationSettings: NotificationSettings(
      showLeagueNotifications: value.showLeagueNotifications,
      showTeamNotifications: !value.showTeamNotifications,
    ),
  );

  Future<void> updateState({
    required NotificationSettings newNotificationSettings,
  }) async {
    value = newNotificationSettings;
    await hive.writeNotificationSettings(newNotificationSettings);
  }

  void testNotification() {
    notification.testNotification();
  }
}
