import 'dart:async';
import 'dart:ui';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../util/dependencies.dart';
import '../util/localization.dart';
import 'hive_service.dart';
import 'logger_service.dart';
import 'notification_service.dart';

class BackgroundFetchService {
  final LoggerService logger;
  final HiveService hive;

  BackgroundFetchService({
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

  /// Initialize Android headless background fetch support.
  Future<void> initializeHeadlessTask() async {
    await BackgroundFetch.registerHeadlessTask(callbackDispatcher);
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

  Future<void> startTask() async {
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiredNetworkType: NetworkType.ANY,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
      ),
      (taskId) async {
        try {
          await runTask();
        } finally {
          await BackgroundFetch.finish(taskId);
        }
      },
      (taskId) async {
        await BackgroundFetch.finish(taskId);
      },
    );
  }

  Future<void> stopTask() async {
    await BackgroundFetch.stop();
  }
}

@pragma('vm:entry-point')
Future<void> callbackDispatcher(HeadlessEvent task) async {
  final taskId = task.taskId;

  if (task.timeout) {
    await BackgroundFetch.finish(taskId);
    return;
  }

  try {
    await runTask();
  } finally {
    await BackgroundFetch.finish(taskId);
  }
}

@pragma('vm:entry-point')
Future<void> runTask() async {
  try {
    /// If task is triggered between `00:00` and `12:00`, don't do anything
    final hour = DateTime.now().hour;
    if (hour >= 0 && hour <= 12) {
      return;
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
  } catch (_) {
    return;
  }
}
