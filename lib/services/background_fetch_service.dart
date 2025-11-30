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

  /// Toggle task, depending on notifications being active
  Future<void> toggleTask() async {
    final notificationSettings = hive.getNotificationSettings();

    if (notificationSettings.showLeagueNotifications || notificationSettings.showTeamNotifications) {
      await startTask();
    } else {
      await stopTask();
    }
  }

  Future<void> startTask() async => BackgroundFetch.start();

  Future<void> stopTask() async => BackgroundFetch.stop();

  Future<void> initializeHeadlessTask() async {
    /// Register headless task
    await BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

    /// Configure [BackgroundFetch]
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 20,
        startOnBoot: true,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),

      /// Task logic
      (taskId) async {
        /// If task is triggered between `00:00` and `06:00`, don't do anything
        final hour = DateTime.now().hour;
        if (hour >= 0 && hour <= 6) {
          await BackgroundFetch.finish(taskId);
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
        );

        /// Wait for initialization to finish
        await getIt.allReady();

        /// Fetch fixtures and show notifications
        await getIt.get<NotificationService>().fetchFixturesAndNotify();

        /// Finish task
        await BackgroundFetch.finish(taskId);
      },

      /// Task timeout logic
      (taskId) async {
        await BackgroundFetch.finish(taskId);
      },
    );
  }
}

@pragma('vm:entry-point')
Future<void> backgroundFetchHeadlessTask(HeadlessTask task) async {
  final taskId = task.taskId;
  final isTimeout = task.timeout;

  /// Task is timed out, finish it immediately
  if (isTimeout) {
    await BackgroundFetch.finish(taskId);
    return;
  }

  ///
  /// Task logic
  ///

  /// If task is triggered between `00:00` and `06:00`, don't do anything
  final hour = DateTime.now().hour;
  if (hour >= 0 && hour <= 6) {
    await BackgroundFetch.finish(taskId);
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
  );

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Fetch fixtures and show notifications
  await getIt.get<NotificationService>().fetchFixturesAndNotify();

  /// Finish task
  await BackgroundFetch.finish(taskId);
}
