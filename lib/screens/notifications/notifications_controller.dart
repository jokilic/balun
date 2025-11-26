import 'package:flutter/material.dart';

import '../../models/notification/notification_settings.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';

class NotificationsController extends ValueNotifier<NotificationSettings> {
  final LoggerService logger;
  final HiveService hive;

  NotificationsController({
    required this.logger,
    required this.hive,
  }) : super(hive.getNotificationSettings());

  ///
  /// METHODS
  ///

  Future<void> updateState({
    required NotificationSettings newNotificationSettings,
  }) async {
    value = newNotificationSettings;
    await hive.writeNotificationSettings(newNotificationSettings);
  }
}
