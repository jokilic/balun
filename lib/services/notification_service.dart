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
import '../util/notifications.dart';
import '../util/string.dart';
import '../util/word_mix.dart';
import 'api_service.dart';
import 'dio_service.dart';
import 'hive_service.dart';
import 'league_storage_service.dart';
import 'logger_service.dart';
import 'match_storage_service.dart';
import 'remote_settings_service.dart';
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

  Future<void> init({bool overrideInit = false}) async {
    final notificationSettings = hive.getNotificationSettings();

    /// Notifications are not initialized & they are enabled in settings
    if (flutterLocalNotificationsPlugin == null &&
        (overrideInit || (notificationSettings.showLeagueNotifications || notificationSettings.showTeamNotifications || notificationSettings.showMatchNotifications))) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await initializeNotifications();
      await requestNotificationPermissions();
    }
  }

  ///
  /// METHODS
  ///

  /// Fetches today's fixtures and generates notification data
  Future<void> fetchFixturesAndNotify({bool isTesting = false}) async {
    /// Initialize notifications if they're not initialized
    if (flutterLocalNotificationsPlugin == null) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await initializeNotifications();
    }

    /// Check permissions
    final permissionsGranted = await requestNotificationPermissions();

    /// Permissions not granted, don't do anything
    if (!permissionsGranted) {
      return;
    }

    /// Generate `currentDate` in a format suitable for backend
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);

    /// Store `hour` in a seperate variable
    final hour = now.hour;

    /// Do logic if within timeframe
    final isInRange = (hour >= 15) || (hour == 0);

    /// Get notification settings
    final notificationSettings = hive.getNotificationSettings();

    /// Currently within timeframe, run logic
    if (isTesting || isInRange) {
      /// Get today fixtures
      final todayFixtures = await fetchTodayFixtures(
        currentDate: currentDate,
      );

      /// Fixtures fetched successfully, continue
      if (todayFixtures?.isNotEmpty ?? false) {
        /// Get favorite leagues, teams & matches
        final favoriteLeagues = getIt.get<LeagueStorageService>().value;
        final favoriteTeams = getIt.get<TeamStorageService>().value;
        final favoriteMatches = getIt.get<MatchStorageService>().value;

        /// Get favorite leagues & teams `IDs`
        final favoriteLeagueIds = favoriteLeagues.map((league) => league.id).whereType<int>().toSet();
        final favoriteTeamsIds = favoriteTeams.map((team) => team.id).whereType<int>().toSet();
        final favoriteMatchIds = favoriteMatches.map((match) => match.matchId).whereType<int>().toSet();

        /// Get fixtures which contain favorited leagues & teams
        final monitoredFixtures = todayFixtures!.where((fixture) {
          final inFavLeague = favoriteLeagueIds.contains(fixture.league?.id);
          final hasFavTeam = favoriteTeamsIds.contains(fixture.teams?.home?.id) || favoriteTeamsIds.contains(fixture.teams?.away?.id);
          final isFavMatch = favoriteMatchIds.contains(fixture.fixture?.id);

          return (notificationSettings.showLeagueNotifications && inFavLeague) ||
              (notificationSettings.showTeamNotifications && hasFavTeam) ||
              (notificationSettings.showMatchNotifications && isFavMatch);
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

          /// Store `mixLogos` value
          final mixLogos = getIt.get<RemoteSettingsService>().value.mixLogos;

          /// Store team names
          final homeTeamName = fixture.teams?.home?.name;
          final awayTeamName = fixture.teams?.away?.name;

          /// Store team logos
          final homeLogoUrl = mixLogos ? null : fixture.teams?.home?.logo;
          final awayLogoUrl = mixLogos ? null : fixture.teams?.away?.logo;

          final isAndroid = defaultTargetPlatform == TargetPlatform.android;

          String formatTeamName(String? teamName) {
            final name = teamName ?? '--';
            return isAndroid ? '<b>$name</b>' : name;
          }

          String scoreLine() => '${mixOrOriginalWords(formatTeamName(homeTeamName))} $currentHomeGoals - $currentAwayGoals ${mixOrOriginalWords(formatTeamName(awayTeamName))}';

          String fixtureLine() => '${mixOrOriginalWords(formatTeamName(homeTeamName))} - ${mixOrOriginalWords(formatTeamName(awayTeamName))}';

          /// Build line for match start notification
          if (hasMatchStarted) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.matchStarted,
                title: 'notificationMatchStart'.tr(),
                body: fixtureLine(),
                summaryLine: '[KICKOFF] ${fixtureLine()}',
                payload: '$fixtureId',
                homeLogoUrl: homeLogoUrl,
                awayLogoUrl: awayLogoUrl,
              ),
            );
          }

          /// Build line for goal notification
          if (wasGoal && totalGoals > (prev.lastNotifiedTotalGoals ?? 0)) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.goal,
                title: 'notificationGoal'.tr(),
                body: scoreLine(),
                summaryLine: '[GOAL] ${scoreLine()}',
                payload: '$fixtureId',
                homeLogoUrl: homeLogoUrl,
                awayLogoUrl: awayLogoUrl,
              ),
            );
          }

          /// Build line for half-time notification
          if (isHalfTime) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.halfTime,
                title: 'notificationHalfTime'.tr(),
                body: scoreLine(),
                summaryLine: '[HT] ${scoreLine()}',
                payload: '$fixtureId',
                homeLogoUrl: homeLogoUrl,
                awayLogoUrl: awayLogoUrl,
              ),
            );
          }

          /// Build line for extra-time notification
          if (isExtraTime) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.extraTime,
                title: 'notificationExtraTime'.tr(),
                body: scoreLine(),
                summaryLine: '[ET] ${scoreLine()}',
                payload: '$fixtureId',
                homeLogoUrl: homeLogoUrl,
                awayLogoUrl: awayLogoUrl,
              ),
            );
          }

          /// Build line for penalties notification
          if (isPenalties) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.penalties,
                title: 'notificationPenalties'.tr(),
                body: scoreLine(),
                summaryLine: '[PEN] ${scoreLine()}',
                payload: '$fixtureId',
                homeLogoUrl: homeLogoUrl,
                awayLogoUrl: awayLogoUrl,
              ),
            );
          }

          /// Build line for full-time notification
          if (isFullTime) {
            changes.add(
              NotificationChange(
                fixtureId: fixtureId,
                type: NotificationChangeType.fullTime,
                title: 'notificationFullTime'.tr(),
                body: scoreLine(),
                summaryLine: '[FT] ${scoreLine()}',
                payload: '$fixtureId',
                homeLogoUrl: homeLogoUrl,
                awayLogoUrl: awayLogoUrl,
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
          await showGroupedFixturesNotifications(
            changes,
            playNotificationSound: notificationSettings.playNotificationSound,
          );
        }
      }
    }

    /// Show notification if testing is done
    if (isTesting) {
      /// Generate notification `id`
      final id = DateTime.now().millisecondsSinceEpoch % 1000000000;

      /// Show notification
      await showNotification(
        title: 'notificationsTriggerNotificationsNotificationTitle'.tr(),
        text: 'notificationsTriggerNotificationsNotificationSubtitle'.tr(),
        notificationId: id,
        playNotificationSound: notificationSettings.playNotificationSound,
      );
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

  /// Shows notifications for fixtures
  Future<void> showGroupedFixturesNotifications(
    List<NotificationChange> changes, {
    required bool playNotificationSound,
  }) async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;

    final dio = getIt.get<DioService>().footballDio;

    /// Individual notifications
    for (var i = 0; i < changes.length; i++) {
      final change = changes[i];

      /// Generate team logos for notification
      final hasLogos = (change.homeLogoUrl?.isNotEmpty ?? false) && (change.awayLogoUrl?.isNotEmpty ?? false);

      ByteArrayAndroidBitmap? largeIcon;
      if (isAndroid && hasLogos) {
        largeIcon = await buildAndroidTeamLogosLargeIcon(
          dio: dio,
          homeLogoUrl: change.homeLogoUrl,
          awayLogoUrl: change.awayLogoUrl,
        );
      }

      List<DarwinNotificationAttachment>? iosAttachments;
      if (hasLogos && isiOS) {
        iosAttachments = await buildIosTeamLogoAttachments(
          dio: dio,
          homeLogoUrl: change.homeLogoUrl,
          awayLogoUrl: change.awayLogoUrl,
        );
      }

      /// Generate notification details for `Android`
      final androidDetails = AndroidNotificationDetails(
        groupChannelId,
        groupChannelName,
        channelDescription: groupChannelDescription,
        sound: playNotificationSound ? const RawResourceAndroidNotificationSound('notification') : null,
        playSound: playNotificationSound,
        importance: Importance.max,
        priority: Priority.high,
        groupKey: groupKey,
        largeIcon: largeIcon,
        styleInformation: DefaultStyleInformation(
          isAndroid,
          isAndroid,
        ),
        ticker: 'ticker',
      );

      /// Generate notification details for `iOS`
      final iOSDetails = DarwinNotificationDetails(
        threadIdentifier: threadIdentifier,
        attachments: iosAttachments,
        sound: playNotificationSound ? 'sound.aiff' : null,
        presentSound: playNotificationSound,
      );

      /// Show notification
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
      htmlFormatLines: isAndroid,
      htmlFormatContentTitle: isAndroid,
      htmlFormatSummaryText: isAndroid,
      htmlFormatContent: isAndroid,
      htmlFormatTitle: isAndroid,
      contentTitle: '$count ${'notificationUpdates'.tr()}',
      summaryText: 'notificationSummaryText'.tr(),
    );

    final summaryAndroidDetails = AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      channelDescription: groupChannelDescription,
      sound: const RawResourceAndroidNotificationSound('notification'),
      playSound: playNotificationSound,
      styleInformation: inboxStyle,
      groupKey: groupKey,
      number: count,
      setAsGroupSummary: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    final summaryIOSDetails = DarwinNotificationDetails(
      threadIdentifier: threadIdentifier,
      badgeNumber: count,
      subtitle: 'notificationSummaryText'.tr(),
      sound: 'sound.aiff',
      presentSound: playNotificationSound,
    );

    /// Generate notification `id`
    final id = DateTime.now().millisecondsSinceEpoch % 1000000000;

    await flutterLocalNotificationsPlugin?.show(
      id,
      'notificationSummaryText'.tr(),
      '$count ${'notificationUpdates'.tr()}',
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
  Future<void> testNotification({required bool playNotificationSound}) async {
    try {
      /// Initialize notifications if they're not initialized
      if (flutterLocalNotificationsPlugin == null) {
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        await initializeNotifications();
      }

      /// Check permissions
      final permissionsGranted = await requestNotificationPermissions();

      /// Permissions not granted, don't do anything
      if (!permissionsGranted) {
        return;
      }

      /// Generate notification `id`
      final id = DateTime.now().millisecondsSinceEpoch % 1000000000;

      /// Show notification
      await showNotification(
        title: 'notificationsTestNotificationNotificationTitle'.tr(),
        text: getRandomFootballJoke(),
        notificationId: id,
        playNotificationSound: playNotificationSound,
      );
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
    required bool playNotificationSound,
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
        sound: const RawResourceAndroidNotificationSound('notification'),
        playSound: playNotificationSound,
        styleInformation: bigTextStyleInformation,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      final iosNotificationDetails = DarwinNotificationDetails(
        categoryIdentifier: 'balun_category_id',
        sound: 'sound.aiff',
        presentSound: playNotificationSound,
      );

      final macOSNotificationDetails = DarwinNotificationDetails(
        categoryIdentifier: 'balun_category_id',
        sound: 'sound.aiff',
        presentSound: playNotificationSound,
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
