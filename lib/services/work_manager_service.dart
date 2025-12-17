import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../util/dependencies.dart';
import '../util/localization.dart';
import 'hive_service.dart';
import 'logger_service.dart';
import 'notification_service.dart';

/// Task name for the periodic work manager task
const uniqueName = 'balun_background_task';
const taskName = 'balun_periodic_task';

class WorkManagerService {
  final LoggerService logger;
  final HiveService hive;

  WorkManagerService({
    required this.logger,
    required this.hive,
  });

  ///
  /// INIT
  ///

  Future<void> init() async {
    await initializeHeadlessTask();
    await toggleTask();
  }

  ///
  /// METHODS
  ///

  /// Initialize [Workmanager]
  Future<void> initializeHeadlessTask() async {
    await Workmanager().initialize(callbackDispatcher);
  }

  /// Toggle task, depending on notifications being active
  Future<void> toggleTask() async {
    final notificationSettings = hive.getNotificationSettings();

    if (notificationSettings.showLeagueNotifications || notificationSettings.showTeamNotifications || notificationSettings.showMatchNotifications) {
      await startTask();
    } else {
      await stopTask();
    }
  }

  Future<void> startTask() async => Workmanager().registerPeriodicTask(
    uniqueName,
    taskName,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
    ),
  );

  Future<void> stopTask() async => Workmanager().cancelAll();
}

@pragma('vm:entry-point')
void callbackDispatcher() => Workmanager().executeTask(
  (_, __) async {
    try {
      /// If task is triggered between `00:00` and `12:00`, don't do anything
      final hour = DateTime.now().hour;
      if (hour >= 0 && hour <= 12) {
        return Future.value(true);
      }

      /// Initialize Flutter related tasks
      WidgetsFlutterBinding.ensureInitialized();
      DartPluginRegistrant.ensureInitialized();

      /// Initialize [EasyLocalization]
      await initializeLocalization();

      /// Initialize services
      initializeServices(
        enableRemoteSettings: !kDebugMode && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS),
        enablePeriodicFetching: !kDebugMode,
        useDioInterceptors: false,
      );

      /// Wait for initialization to finish
      await getIt.allReady();

      /// Fetch fixtures and show notifications
      await getIt.get<NotificationService>().fetchFixturesAndNotify();

      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    }
  },
);
