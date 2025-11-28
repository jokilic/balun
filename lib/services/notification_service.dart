import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_ce/hive.dart';

import '../main.dart';
import '../models/fixtures/fixture_response.dart';
import '../models/notification/notification_change.dart';
import '../models/notification/notification_fixture.dart';
import '../routing.dart';
import '../util/date_time.dart';
import '../util/dependencies.dart';
import '../util/localization.dart';
import '../util/string.dart';
import 'api_service.dart';
import 'hive_service.dart';
import 'league_storage_service.dart';
import 'logger_service.dart';
import 'team_storage_service.dart';

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

  final groupKey = 'com.josipkilic.balun.fixture_updates';
  final groupChannelId = 'balun_channel_id';
  final groupChannelName = 'Balun notifications';
  final groupChannelDescription = 'Notifications shown by the Balun app';
  final threadIdentifier = 'fixture_updates_thread';

  ///
  /// INIT
  ///

  Future<void> init() async {
    final notificationSettings = hive.getNotificationSettings();

    /// Notifications are not initialized & they are enabled in settings
    if (flutterLocalNotificationsPlugin == null && (notificationSettings.showLeagueNotifications || notificationSettings.showTeamNotifications)) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await initializeNotifications();
      await requestNotificationPermissions();
    }
  }

  ///
  /// METHODS
  ///

  /// Fetches today's fixtures and generates notification data
  Future<void> fetchFixturesAndNotify() async {
    /// Generate `currentDate` in a format suitable for backend
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);

    /// Store `hour` in a seperate variable
    final hour = now.hour;

    /// Do logic if within timeframe
    // final isInRange = (hour >= 15) || (hour == 0);
    // TODO: Remove this and introduce commented out value
    final isInRange = (hour >= 10) || (hour == 0);

    /// Currently within timeframe, run logic
    if (isInRange) {
      /// Get today fixtures
      final todayFixtures = await fetchTodayFixtures(
        currentDate: currentDate,
      );

      /// Fixtures fetched successfully, continue
      if (todayFixtures?.isNotEmpty ?? false) {
        /// Get favorite leagues & teams
        final favoriteLeagues = getIt.get<LeagueStorageService>().value;
        final favoriteTeams = getIt.get<TeamStorageService>().value;

        /// Get notification settings
        final notificationSettings = hive.getNotificationSettings();

        /// Get favorite leagues & teams `IDs`
        final favoriteLeagueIds = favoriteLeagues.map((league) => league.id).toList();
        final favoriteTeamsIds = favoriteTeams.map((team) => team.id).toList();

        /// Get fixtures which contain favorited leagues & teams
        final monitoredFixtures = todayFixtures!.where((fixture) {
          final inFavLeague = favoriteLeagueIds.contains(fixture.league?.id);
          final hasFavTeam = favoriteTeamsIds.contains(fixture.teams?.home?.id) || favoriteTeamsIds.contains(fixture.teams?.away?.id);

          return (notificationSettings.showLeagueNotifications && inFavLeague) || (notificationSettings.showTeamNotifications && hasFavTeam);
        }).toList();

        /// Get box of [NotificationFixtures] from [Hive]
        final hiveNotificationFixturesBox = Hive.box<NotificationFixture>('notificationFixturesBox');

        /// Collect all changes here
        final changes = <NotificationChange>[];

        for (final fixture in monitoredFixtures) {
          /// Get `fixtureId` and value from [Hive] if exists
          final fixtureId = fixture.fixture?.id;
          final prev = hiveNotificationFixturesBox.get(fixtureId);

          /// Store current state of goals
          final currentHomeGoals = fixture.goals?.home;
          final currentAwayGoals = fixture.goals?.away;

          /// Store current fixture status
          final statusShort = fixture.fixture?.status?.short;

          /// Calculate total goals now and before
          final totalGoals = (currentHomeGoals ?? 0) + (currentAwayGoals ?? 0);
          final prevTotalGoals = (prev?.homeGoals ?? 0) + (prev?.awayGoals ?? 0);

          /// Check if match just started
          final hasMatchStarted =
              prev != null &&
              isMatchNotStarted(
                statusShort: prev.statusShort ?? '--',
              ) &&
              isMatchPlaying(
                statusShort: statusShort ?? '--',
              );

          /// Check if a goal happened
          final wasGoal =
              prev != null &&
              totalGoals > prevTotalGoals &&
              isMatchPlaying(
                statusShort: statusShort ?? '--',
              );

          /// Check if half-time happened
          final isHalfTime = statusShort == 'HT' && (prev == null || prev.statusShort != 'HT') && !(prev?.halfTimeNotified ?? false);

          /// Check if extra-time happened
          final isExtraTime = statusShort == 'ET' && (prev == null || prev.statusShort != 'ET') && !(prev?.extraTimeNotified ?? false);

          /// Check if penalties happened
          final isPenalties = statusShort == 'P' && (prev == null || prev.statusShort != 'P') && !(prev?.penaltiesNotified ?? false);

          /// Check if full-time happened
          final isFullTime =
              isMatchFinished(
                statusShort: statusShort ?? '--',
              ) &&
              (prev == null ||
                  !isMatchFinished(
                    statusShort: prev.statusShort ?? '--',
                  )) &&
              !(prev?.fullTimeNotified ?? false);

          /// Store team names
          final homeTeamName = fixture.teams?.home?.name;
          final awayTeamName = fixture.teams?.away?.name;

          // TODO: Localize all values below & changes values

          // TODO: Make with bold if Android
          // TODO: Move this somewhere
          String scoreLine() => '$homeTeamName $currentHomeGoals - $currentAwayGoals $awayTeamName';
          String fixtureLine() => '$homeTeamName - $awayTeamName';

          /// Build line for match start notification
          if (hasMatchStarted) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.matchStarted,
                title: '⏱️ Match start!',
                body: fixtureLine(),
                summaryLine: '[KICKOFF] ${fixtureLine()}',
                payload: '$fixtureId',
              ),
            );
          }

          /// Build line for goal notification
          if (wasGoal && totalGoals > (prev.lastNotifiedTotalGoals ?? 0)) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.goal,
                title: '⚽️ Goal!',
                body: scoreLine(),
                summaryLine: '[GOAL] ${scoreLine()}',
                payload: '$fixtureId',
              ),
            );
          }

          /// Build line for half-time notification
          if (isHalfTime) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.halfTime,
                title: '⏱️ Half time!',
                body: scoreLine(),
                summaryLine: '[HT] ${scoreLine()}',
                payload: '$fixtureId',
              ),
            );
          }

          /// Build line for extra-time notification
          if (isExtraTime) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.extraTime,
                title: '⏱️ Extra time!',
                body: scoreLine(),
                summaryLine: '[ET] ${scoreLine()}',
                payload: '$fixtureId',
              ),
            );
          }

          /// Build line for penalties notification
          if (isPenalties) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.penalties,
                title: '⏱️ Penalties!',
                body: scoreLine(),
                summaryLine: '[PEN] ${scoreLine()}',
                payload: '$fixtureId',
              ),
            );
          }

          /// Build line for full-time notification
          if (isFullTime) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.fullTime,
                title: '⏱️ Full time!',
                body: scoreLine(),
                summaryLine: '[FT] ${scoreLine()}',
                payload: '$fixtureId',
              ),
            );
          }

          /// Save fixture snapshot to [Hive]
          await hiveNotificationFixturesBox.put(
            fixtureId,
            NotificationFixture(
              fixtureId: fixtureId,
              homeName: homeTeamName,
              awayName: awayTeamName,
              homeGoals: currentHomeGoals,
              awayGoals: currentAwayGoals,
              statusShort: statusShort,
              halfTimeNotified: isHalfTime || (prev?.halfTimeNotified ?? false),
              extraTimeNotified: isExtraTime || (prev?.extraTimeNotified ?? false),
              penaltiesNotified: isPenalties || (prev?.penaltiesNotified ?? false),
              fullTimeNotified: isFullTime || (prev?.fullTimeNotified ?? false),
              lastNotifiedTotalGoals: wasGoal ? totalGoals : (prev?.lastNotifiedTotalGoals ?? totalGoals),
            ),
          );
        }

        /// Cleanup old fixture snapshots (yesterday and earlier)
        final currentFixtureIds = monitoredFixtures.map((fixture) => fixture.fixture?.id).toSet();

        for (final key in hiveNotificationFixturesBox.keys.toList()) {
          if (!currentFixtureIds.contains(key)) {
            await hiveNotificationFixturesBox.delete(key);
          }
        }

        /// Send one grouped notification if there are changes
        if (changes.isNotEmpty) {
          await showGroupedFixturesNotifications(changes);
        }

        /// Show an info notification
        // TODO: Remove this
        await showNotification(
          title: '⚽️ Balun!',
          text: '${changes.length} changes in matches',
          notificationId: 1,
        );
      }
    }
  }

  /// Calls API & fetches fixtures from today
  Future<List<FixtureResponse>?> fetchTodayFixtures({required DateTime currentDate}) async {
    /// Call API
    final response = await api.getFixturesFromDate(
      dateString: getDateForBackend(currentDate),
    );

    /// Successful request
    if (response.fixturesResponse != null && response.error == null) {
      /// Errors exist, return null
      if (response.fixturesResponse!.errors?.isNotEmpty ?? false) {
        return null;
      }
      /// Response is not null, update to success state
      else if (response.fixturesResponse!.response?.isNotEmpty ?? false) {
        return response.fixturesResponse!.response!;
      }
      /// Response is null, return null
      else {
        return null;
      }
    }

    /// Failed request
    if (response.fixturesResponse == null && response.error != null) {
      /// Error is not null, return null
      return null;
    }

    return null;
  }

  Future<void> showGroupedFixturesNotifications(List<NotificationChange> changes) async {
    /// Individual notifications
    for (var i = 0; i < changes.length; i++) {
      final change = changes[i];

      final androidDetails = AndroidNotificationDetails(
        groupChannelId,
        groupChannelName,
        channelDescription: groupChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        groupKey: groupKey,
      );

      final iOSDetails = DarwinNotificationDetails(
        threadIdentifier: threadIdentifier,
      );

      await flutterLocalNotificationsPlugin?.show(
        change.fixtureId ?? i,
        change.title,
        change.body,
        NotificationDetails(
          android: androidDetails,
          iOS: iOSDetails,
        ),
        payload: change.payload,
      );
    }

    /// Summary notification
    final lines = changes.map((c) => c.summaryLine ?? '--').toList();
    final count = changes.length;

    final inboxStyle = InboxStyleInformation(
      lines,
      // TODO: Localize
      contentTitle: '$count updates in your favourites',
      summaryText: 'Your favourite matches',
    );

    final summaryAndroidDetails = AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      channelDescription: groupChannelDescription,
      styleInformation: inboxStyle,
      groupKey: groupKey,
      setAsGroupSummary: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    final summaryIOSDetails = DarwinNotificationDetails(
      threadIdentifier: threadIdentifier,
    );

    /// Generate notification `id`
    final id = DateTime.now().millisecondsSinceEpoch % 1000000000;

    await flutterLocalNotificationsPlugin?.show(
      id,
      // TODO: Localize
      'Match updates',
      '$count updates in your favourites',
      NotificationDetails(
        android: summaryAndroidDetails,
        iOS: summaryIOSDetails,
      ),
    );
  }

  /// Initializes [FlutterLocalNotifications] plugin
  Future<bool> initializeNotifications() async {
    try {
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
        /// Generate notification `id`
        final id = DateTime.now().millisecondsSinceEpoch % 1000000000;

        /// Show notification
        await showNotification(
          title: 'notificationsTestNotificationTitle'.tr(),
          text: getRandomFootballJoke(),
          notificationId: id,
        );
      }
    } catch (e) {
      final error = 'TestNotification -> catch -> $e';
      logger.e(error);
    }
  }

  /// Returns a random football joke
  String getRandomFootballJoke() {
    final random = Random();
    final index = random.nextInt(50);
    return 'footballJoke${index + 1}'.tr();
  }

  /// Shows a notification
  Future<void> showNotification({
    required String title,
    required String text,
    required int notificationId,
    String? payload,
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

      await flutterLocalNotificationsPlugin?.show(
        notificationId,
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

  /// Triggered when user presses a notification
  Future<void> handlePressedNotification({required String? payload}) async {
    try {
      final context = navigatorKey.currentState?.context;

      if (payload != null && context != null) {
        /// Parse `payload` to `int`
        final payloadFixtureId = int.tryParse(payload);

        /// Navigate to base route
        Navigator.of(context).popUntil((route) => route.isFirst);

        /// `fixtureId` is parsed properly, open [MatchScreen]
        if (payloadFixtureId != null) {
          openMatch(
            context,
            matchId: payloadFixtureId,
          );
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
  initializeServices(
    enableRemoteSettings: !kDebugMode && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS),
    enablePeriodicFetching: !kDebugMode,
  );

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Handle notification
  await getIt.get<NotificationService>().handlePressedNotification(
    payload: notificationResponse.payload,
  );
}
