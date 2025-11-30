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
      newShowLeagueNotifications: !value.showLeagueNotifications,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedFavoriteTeams() async {
    await updateState(
      newShowTeamNotifications: !value.showTeamNotifications,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedFavoriteMatches() async {
    await updateState(
      newShowMatchNotifications: !value.showMatchNotifications,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedTriggerMatchStart() async {
    await updateState(
      newTriggerMatchStart: !value.triggerMatchStart,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedTriggerGoal() async {
    await updateState(
      newTriggerGoal: !value.triggerGoal,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedTriggerMatchProgress() async {
    await updateState(
      newTriggerMatchProgress: !value.triggerMatchProgress,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedTriggerFullTime() async {
    await updateState(
      newTriggerFullTime: !value.triggerFullTime,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  Future<void> onPressedNotificationSound() async {
    await updateState(
      newPlayNotificationSound: !value.playNotificationSound,
    );

    /// Initialize notifications if necessary
    await notification.init(
      overrideInit: true,
    );

    /// Toggle task, depending on notifications being active
    await backgroundFetch.toggleTask();
  }

  void testNotification() => notification.testNotification(
    playNotificationSound: hive.getNotificationSettings().playNotificationSound,
  );

  void triggerNotifications() => notification.fetchFixturesAndNotify(
    isTesting: true,
  );

  Future<void> updateState({
    bool? newShowLeagueNotifications,
    bool? newShowTeamNotifications,
    bool? newShowMatchNotifications,
    bool? newTriggerMatchStart,
    bool? newTriggerGoal,
    bool? newTriggerMatchProgress,
    bool? newTriggerFullTime,
    bool? newPlayNotificationSound,
  }) async {
    final newNotificationSettings = NotificationSettings(
      showLeagueNotifications: newShowLeagueNotifications ?? value.showLeagueNotifications,
      showTeamNotifications: newShowTeamNotifications ?? value.showTeamNotifications,
      showMatchNotifications: newShowMatchNotifications ?? value.showMatchNotifications,
      triggerMatchStart: newTriggerMatchStart ?? value.triggerMatchStart,
      triggerGoal: newTriggerGoal ?? value.triggerGoal,
      triggerMatchProgress: newTriggerMatchProgress ?? value.triggerMatchProgress,
      triggerFullTime: newTriggerFullTime ?? value.triggerFullTime,
      playNotificationSound: newPlayNotificationSound ?? value.playNotificationSound,
    );

    value = newNotificationSettings;
    await hive.writeNotificationSettings(newNotificationSettings);
  }
}
