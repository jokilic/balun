import 'dart:async';
import 'dart:ui';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';

import 'hive_service.dart';
import 'logger_service.dart';

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

    // TODO: Enable or disable depending on Hive value
  }

  ///
  /// METHODS
  ///

  Future<void> startFetching() async => BackgroundFetch.start();

  Future<void> stopFetching() async => BackgroundFetch.stop();

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
        // await initializeLocalization();

        /// Initialize services
        // final initialization = await initializeServices();

        /// Everything initialized successfully
        // if (initialization?.container != null) {
        //   ///
        //   /// Notifications
        //   ///
        //   await initialization!.container!.read(notificationProvider).handleNotifications();

        //   ///
        //   /// Widget
        //   ///
        //   await initialization.container!
        //       .read(homeWidgetProvider)
        //       .handleWidget(
        //         languageCode: 'en',
        //       );
        // }

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
  // await initializeLocalization();

  /// Initialize services
  // final initialization = await initializeServices();

  /// Everything initialized successfully
  // if (initialization?.container != null) {
  //   ///
  //   /// Notifications
  //   ///
  //   await initialization!.container!.read(notificationProvider).handleNotifications();

  //   ///
  //   /// Widget
  //   ///
  //   await initialization.container!
  //       .read(homeWidgetProvider)
  //       .handleWidget(
  //         languageCode: 'en',
  //       );
  // }

  /// Finish task
  await BackgroundFetch.finish(taskId);
}
