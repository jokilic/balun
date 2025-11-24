import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import '../theme/icons.dart';
import 'api_service.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class NotificationService {
  final LoggerService logger;
  final HiveService hive;
  final APIService api;

  NotificationService({
    required this.logger,
    required this.hive,
    required this.api,
  });

  ///
  /// VARIABLES
  ///

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final settings = hive.getPromajaSettingsFromBox();

    /// Notifications are not initialized & they are enabled in settings
    if (flutterLocalNotificationsPlugin == null &&
        (settings.notification.hourlyNotification || settings.notification.morningNotification || settings.notification.eveningNotification)) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await initializeNotifications();
      await requestNotificationPermissions();
    }
  }

  ///
  /// METHODS
  ///

  /// Initializes [FlutterLocalNotifications] plugin
  Future<bool> initializeNotifications() async {
    try {
      // TODO: Icon
      /// `Android`
      const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

      /// `iOS`
      const initializationSettingsDarwin = DarwinInitializationSettings();

      /// Initialization settings
      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
      );

      final initialized = await flutterLocalNotificationsPlugin?.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
      );

      return initialized ?? false;
    } catch (e) {
      final error = 'InitializeNotifications -> catch -> $e';
      logger.e(error);
      return false;
    }
  }

  /// Triggers notification permission dialog
  Future<bool> requestNotificationPermissions() async {
    try {
      bool? permissionsGranted;

      /// `Android` notifications
      if (defaultTargetPlatform == TargetPlatform.android) {
        permissionsGranted =
            await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled() ?? false;

        if (!permissionsGranted) {
          permissionsGranted =
              await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission() ?? false;
        }
      }

      /// `iOS` notifications
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        permissionsGranted =
            await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
              alert: true,
              badge: true,
            ) ??
            false;
      }

      /// `MacOS` notifications
      if (defaultTargetPlatform == TargetPlatform.macOS) {
        permissionsGranted =
            await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
              alert: true,
              badge: true,
            ) ??
            false;
      }

      /// Error while granting permissions
      if (permissionsGranted == null) {
        const error = 'RequestNotificationPermissions -> Notification platform different than Android, iOS or MacOS';
        logger.e(error);
        return false;
      }

      if (!permissionsGranted) {
        const error = 'RequestNotificationPermissions -> Notification permissions denied';
        logger.e(error);
      }

      return permissionsGranted;
    } catch (e) {
      final error = 'RequestNotificationPermissions -> catch -> $e';
      logger.e(error);

      return false;
    }
  }

  /// Cancels all notifications
  Future<void> cancelNotifications() async {
    try {
      await flutterLocalNotificationsPlugin?.cancelAll();
    } catch (e) {
      final error = 'CancelNotifications -> catch -> $e';
      logger.e(error);
    }
  }

  /// Shows a notification
  Future<void> showNotification({
    required String title,
    required String text,
    required NotificationType notificationType,
  }) async {
    try {
      final bigTextStyleInformation = BigTextStyleInformation(
        text,
        contentTitle: title,
        htmlFormatBigText: true,
        htmlFormatContent: true,
      );

      final androidNotificationDetails = AndroidNotificationDetails(
        'balun_channel_id',
        'Balun notifications',
        channelDescription: 'Notifications shown by the Balun app',
        styleInformation: bigTextStyleInformation,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      const iosNotificationDetails = DarwinNotificationDetails(
        categoryIdentifier: 'balun_category_id',
      );

      const macOSNotificationDetails = DarwinNotificationDetails(
        categoryIdentifier: 'balun_category_id',
      );

      final notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
        macOS: macOSNotificationDetails,
      );

      final payload = NotificationPayload(
        notificationType: notificationType,
      ).toJson();

      await flutterLocalNotificationsPlugin?.show(
        notificationType.index,
        title,
        text,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      final error = 'ShowNotification -> catch -> $e';
      logger.e(error);
    }
  }

  /// Shows a test notification
  Future<void> testNotification() async {
    try {
      /// Initialize notifications if they're not initialized
      if (flutterLocalNotificationsPlugin == null) {
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        await initializeNotifications();
      }

      /// Check permissions
      final permissionsGranted = await requestNotificationPermissions();

      if (permissionsGranted) {
        /// Show notification
        await showNotification(
          title: 'testNotificationTitle'.tr(),
          text: getRandomWeatherJoke(),
          notificationType: NotificationType.test,
        );
      }
    } catch (e) {
      final error = 'TestNotification -> catch -> $e';
      logger.e(error);
    }
  }

  /// Returns a random weather joke
  String getRandomWeatherJoke() {
    final random = Random();
    final index = random.nextInt(50);
    return 'weatherJoke${index + 1}'.tr();
  }

  /// Handles notification logic, depending on `NotificationSettings`
  Future<void> handleNotifications() async {
    try {
      final settings = hive.getPromajaSettingsFromBox();

      final location = settings.notification.location;

      /// Location exists
      if (location != null) {
        ///
        /// Hourly notification is active, fetch current weather and show it
        ///
        if (settings.notification.hourlyNotification) {
          /// Fetch current weather
          final currentWeather = await api.fetchCurrentWeather(
            location: location,
          );

          /// Current weather is successfully fetched
          if (currentWeather != null) {
            await triggerHourlyNotification(
              currentWeather: currentWeather,
              showCelsius: settings.unit.temperature == TemperatureUnit.celsius,
              location: location,
            );
          }
        }

        ///
        /// Morning notification is active
        ///
        if (settings.notification.morningNotification) {
          /// Check if notification should be triggered
          final shouldShowNotification = shouldTriggerNotification(
            isEveningNotification: false,
          );

          /// Notification should be shown
          if (shouldShowNotification) {
            /// Fetch today's forecast
            final forecastWeather = await api.fetchForecastWeather(
              location: location,
              isTomorrow: false,
            );

            /// Forecast weather is successfully fetched
            if (forecastWeather != null) {
              /// Show notification
              await triggerForecastNotification(
                forecastWeather: forecastWeather,
                showCelsius: settings.unit.temperature == TemperatureUnit.celsius,
                isEvening: false,
                location: location,
              );

              /// Store new value of `NotificationLastShown` in [Hive]
              final oldNotificationLastShown = hive.getNotificationLastShownFromBox();

              final newNotificationLastShown = NotificationLastShown(
                morningNotificationLastShown: DateTime.now(),
                eveningNotificationLastShown: oldNotificationLastShown?.eveningNotificationLastShown ?? DateTime.fromMillisecondsSinceEpoch(0),
              );

              await hive.addNotificationLastShownToBox(
                notificationLastShown: newNotificationLastShown,
              );
            }
          }
        }

        ///
        /// Evening notification is active
        ///
        if (settings.notification.eveningNotification) {
          /// Check if notification should be triggered
          final shouldShowNotification = shouldTriggerNotification(
            isEveningNotification: true,
          );

          /// Notification should be shown
          if (shouldShowNotification) {
            /// Fetch tomorrow's forecast
            final forecastWeather = await api.fetchForecastWeather(
              location: location,
              isTomorrow: true,
            );

            /// Forecast weather is successfully fetched
            if (forecastWeather != null) {
              /// Show notification
              await triggerForecastNotification(
                forecastWeather: forecastWeather,
                showCelsius: settings.unit.temperature == TemperatureUnit.celsius,
                isEvening: true,
                location: location,
              );

              /// Store new value of `NotificationLastShown` in [Hive]
              final oldNotificationLastShown = hive.getNotificationLastShownFromBox();

              final newNotificationLastShown = NotificationLastShown(
                morningNotificationLastShown: oldNotificationLastShown?.morningNotificationLastShown ?? DateTime.fromMillisecondsSinceEpoch(0),
                eveningNotificationLastShown: DateTime.now(),
              );

              await hive.addNotificationLastShownToBox(
                notificationLastShown: newNotificationLastShown,
              );
            }
          }
        }
      }
      /// Location doesn't exist
      else {
        const error = 'HandleNotifications -> Location is null';
        logger.e(error);
      }
    } catch (e) {
      final error = 'HandleNotifications -> catch -> $e';
      logger.e(error);
    }
  }

  /// Triggers hourly notification with proper data
  Future<void> triggerHourlyNotification({
    required ResponseCurrentWeather currentWeather,
    required bool showCelsius,
    required Location location,
  }) async {
    try {
      /// Store relevant values in variables
      final locationName = currentWeather.location.name;

      final temp = showCelsius ? '${currentWeather.current.tempC.round()}°C' : '${currentWeather.current.tempF.round()}°F';

      final weatherDescription = getWeatherDescription(
        code: currentWeather.current.condition.code,
        isDay: currentWeather.current.isDay == 1,
      );

      final title = 'hourlyNotificationTitle'.tr();

      final text = 'hourlyNotificationText'.tr(
        args: defaultTargetPlatform == TargetPlatform.android
            ? [
                '<b>$locationName</b>',
                '<b>${weatherDescription.toLowerCase()}</b>',
                '<b>$temp</b>',
              ]
            : [
                locationName,
                weatherDescription.toLowerCase(),
                temp,
              ],
      );

      await showNotification(
        title: title,
        text: text,
        notificationType: NotificationType.hourly,
        location: location,
      );
    } catch (e) {
      final error = 'TriggerHourlyNotification -> catch -> $e';
      logger.e(error);
    }
  }

  /// Triggers forecast notification with proper data
  Future<void> triggerForecastNotification({
    required ResponseForecastWeather forecastWeather,
    required bool showCelsius,
    required bool isEvening,
    required Location location,
  }) async {
    try {
      /// Store relevant values in variables
      final locationName = forecastWeather.location.name;

      final time = DateTime.now().add(
        isEvening ? const Duration(days: 1) : Duration.zero,
      );
      final forecast = forecastWeather.forecast.forecastDays
          .where(
            (forecastDay) => forecastDay.dateEpoch.year == time.year && forecastDay.dateEpoch.month == time.month && forecastDay.dateEpoch.day == time.day,
          )
          .toList()
          .firstOrNull;

      /// Forecast exists, show it
      if (forecast != null) {
        final minTemp = showCelsius ? '${forecast.day.minTempC.round()}°C' : '${forecast.day.minTempF.round()}°F';
        final maxTemp = showCelsius ? '${forecast.day.maxTempC.round()}°C' : '${forecast.day.maxTempF.round()}°F';

        final weatherDescription = getWeatherDescription(
          code: forecast.day.condition.code,
          isDay: true,
        );

        final title = isEvening ? 'eveningNotificationTitle'.tr() : 'morningNotificationTitle'.tr();

        final text = isEvening
            ? 'eveningNotificationText'.tr(
                args: defaultTargetPlatform == TargetPlatform.android
                    ? [
                        '<b>$locationName</b>',
                        '<b>${weatherDescription.toLowerCase()}</b>',
                        '<b>$minTemp</b>',
                        '<b>$maxTemp</b>',
                      ]
                    : [
                        locationName,
                        weatherDescription.toLowerCase(),
                        minTemp,
                        maxTemp,
                      ],
              )
            : 'morningNotificationText'.tr(
                args: defaultTargetPlatform == TargetPlatform.android
                    ? [
                        '<b>$locationName</b>',
                        '<b>${weatherDescription.toLowerCase()}</b>',
                        '<b>$minTemp</b>',
                        '<b>$maxTemp</b>',
                      ]
                    : [
                        locationName,
                        weatherDescription.toLowerCase(),
                        minTemp,
                        maxTemp,
                      ],
              );

        await showNotification(
          title: title,
          text: text,
          notificationType: isEvening ? NotificationType.evening : NotificationType.morning,
          location: location,
        );
      }
    } catch (e) {
      final error = 'TriggerForecastNotification -> ${isEvening ? 'Evening' : 'Morning'} notification -> catch -> $e';
      logger.e(error);
    }
  }

  /// Checks when last notification was triggered and returns `true` if it's more than 20 hours
  bool shouldTriggerNotification({required bool isEveningNotification}) {
    final now = DateTime.now();

    final startHour = isEveningNotification ? 19 : 8;
    final endHour = isEveningNotification ? 21 : 10;

    /// Notification is triggered between `startHour` & `endHour`
    if (now.hour >= startHour && now.hour <= endHour) {
      /// Get [DateTime] when the last notification is triggered
      final lastShownNotification = hive.getNotificationLastShownFromBox();
      final lastShownNotificationDateTime =
          (isEveningNotification ? lastShownNotification?.eveningNotificationLastShown : lastShownNotification?.morningNotificationLastShown) ??
          DateTime.fromMillisecondsSinceEpoch(0);

      /// Calculate difference between the last notification and current time
      final difference = now.difference(lastShownNotificationDateTime);

      /// The difference is more than 20 hours, we should trigger the notification
      return difference.inHours > 20;
    }
    return false;
  }

  /// Triggered when user presses a notification
  Future<void> handlePressedNotification({required String? payload}) async {
    try {
      final context = navigatorKey.currentState?.context;

      if (payload != null && context != null) {
        /// Parse to `NotificationPayload`
        final notificationPayload = NotificationPayload.fromJson(payload);

        /// Navigate to base route
        Navigator.of(context).popUntil((route) => route.isFirst);

        switch (notificationPayload.notificationType) {
          ///
          /// Hourly notification
          ///
          case NotificationType.hourly:
            if (notificationPayload.location != null) {
              /// Get location index
              final locationIndex = ref.read(hiveProvider).indexOf(notificationPayload.location!);

              /// Go to `CardsScreen` with proper location
              ref.read(cardMovingProvider.notifier).moving = false;
              ref.read(cardIndexProvider.notifier).currentIndex = locationIndex;
              if (ref.read(cardAdditionalControllerProvider).hasClients) {
                ref.read(cardAdditionalControllerProvider).jumpTo(0);
              }
              await ref.read(navigationBarIndexProvider.notifier).changeNavigationBarIndex(NavigationBarItems.cards.index);
              await Future.delayed(PromajaDurations.cardsSwiperNotificationDelay);
              for (var i = 0; i < locationIndex; i++) {
                ref.read(cardsSwiperControllerProvider).swipe(CardSwiperDirection.right);
                await Future.delayed(PromajaDurations.cardSwiperAnimation);
              }
            }

          ///
          /// Morning / evening notification
          ///
          case NotificationType.morning:
          case NotificationType.evening:
            if (notificationPayload.location != null) {
              /// Get location index
              final locationIndex = ref.read(hiveProvider).indexOf(notificationPayload.location!);

              /// Go to `ForecastScreen` with proper location
              await ref.read(hiveProvider.notifier).addActiveLocationIndexToBox(index: locationIndex);
              await ref.read(navigationBarIndexProvider.notifier).changeNavigationBarIndex(NavigationBarItems.weather.index);
            }

          ///
          /// Test notification
          ///
          case NotificationType.test:
            logger.f('Hello testy test');
        }
      }
      /// Payload or context is null
      else {
        const error = 'HandlePressedNotification -> Payload or context is null';
        logger.e(error);
      }
    } catch (e) {
      final error = 'HandlePressedNotification -> catch -> $e';
      logger.e(error);
    }
  }

  /// Triggered when the user taps the notification
  Future<void> onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    try {
      await handlePressedNotification(
        payload: notificationResponse.payload,
      );
    } catch (e) {
      final error = 'onDidReceiveNotificationResponse -> catch -> $e';
      logger.e(error);
    }
  }
}

/// Triggered when a notification is received while the app is terminated
@pragma('vm:entry-point')
Future<void> onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) async {
  /// Initialize Flutter related tasks
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  /// Initialize [EasyLocalization]
  await initializeLocalization();

  /// Initialize services
  final initialization = await initializeServices();

  if (initialization?.container != null) {
    await initialization!.container!
        .read(notificationProvider)
        .handlePressedNotification(
          payload: notificationResponse.payload,
        );
  }
}
