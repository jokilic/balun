import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../services/api_service.dart';
import '../services/background_fetch_service.dart';
import '../services/balun_navigation_bar_badge_service.dart';
import '../services/balun_navigation_bar_service.dart';
import '../services/balun_screen_service.dart';
import '../services/dio_service.dart';
import '../services/hive_service.dart';
import '../services/league_storage_service.dart';
import '../services/logger_service.dart';
import '../services/match_storage_service.dart';
import '../services/news_service.dart';
import '../services/notification_service.dart';
import '../services/package_info_service.dart';
import '../services/periodic_api_service.dart';
import '../services/remote_settings_service.dart';
import '../services/team_storage_service.dart';
import '../services/theme_service.dart';
import '../services/youtube_search_service.dart';

final getIt = GetIt.instance;

/// Registers a class if it's not already initialized
/// Optionally runs a function with newly registered class
T registerIfNotInitialized<T extends Object>(
  T Function() factoryFunc, {
  required String instanceName,
  void Function(T controller)? afterRegister,
}) {
  if (!getIt.isRegistered<T>(instanceName: instanceName)) {
    getIt.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
      onCreated: afterRegister != null ? (instance) => afterRegister(instance) : null,
    );
  }

  return getIt.get<T>(instanceName: instanceName);
}

/// Registers an async singleton only when the type is not already registered
void registerSingletonAsyncIfNotInitialized<T extends Object>(
  FactoryFuncAsync<T> factoryFunc, {
  Iterable<Type>? dependsOn,
}) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerSingletonAsync<T>(
      factoryFunc,
      dependsOn: dependsOn,
    );
  }
}

void initializeServices({
  required bool enableRemoteSettings,
  required bool enablePeriodicFetching,
  required bool useDioInterceptors,
}) {
  final internetConnection = InternetConnection.createInstance(
    triggerStream: Connectivity().onConnectivityChanged,
  );

  registerSingletonAsyncIfNotInitialized<LoggerService>(
    () async => LoggerService(),
  );

  registerSingletonAsyncIfNotInitialized<PackageInfoService>(
    () async {
      final packageInfo = PackageInfoService(
        logger: getIt.get<LoggerService>(),
      );
      await packageInfo.init();
      return packageInfo;
    },
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<HiveService>(
    () async {
      final hive = HiveService(
        logger: getIt.get<LoggerService>(),
      );
      await hive.init();
      return hive;
    },
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<ThemeService>(
    () async => ThemeService(
      logger: getIt.get<LoggerService>(),
      hive: getIt.get<HiveService>(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<LeagueStorageService>(
    () async => LeagueStorageService(
      logger: getIt.get<LoggerService>(),
      hiveLeagues: getIt.get<HiveService>().leagues.values.toList(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<TeamStorageService>(
    () async => TeamStorageService(
      logger: getIt.get<LoggerService>(),
      hiveTeams: getIt.get<HiveService>().teams.values.toList(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<MatchStorageService>(
    () async => MatchStorageService(
      logger: getIt.get<LoggerService>(),
      hiveMatches: getIt.get<HiveService>().matches.values.toList(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<DioService>(
    () async => DioService(
      logger: getIt.get<LoggerService>(),
      useInterceptors: useDioInterceptors,
    )..init(),
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<RemoteSettingsService>(
    () async {
      final remoteSettings = RemoteSettingsService(
        logger: getIt.get<LoggerService>(),
        dio: getIt.get<DioService>().remoteSettingsDio,
        internetConnection: internetConnection,
      );
      if (enableRemoteSettings) {
        await remoteSettings.init();
      }
      return remoteSettings;
    },
    dependsOn: [LoggerService, DioService],
  );

  registerSingletonAsyncIfNotInitialized<YouTubeSearchService>(
    () async => YouTubeSearchService(
      logger: getIt.get<LoggerService>(),
      dio: getIt.get<DioService>().youTubeSearchDio,
      internetConnection: internetConnection,
    ),
    dependsOn: [LoggerService, DioService],
  );

  registerSingletonAsyncIfNotInitialized<NewsService>(
    () async => NewsService(
      logger: getIt.get<LoggerService>(),
      dio: getIt.get<DioService>().newsDio,
      internetConnection: internetConnection,
    ),
    dependsOn: [LoggerService, DioService],
  );

  registerSingletonAsyncIfNotInitialized<APIService>(
    () async => APIService(
      logger: getIt.get<LoggerService>(),
      dio: getIt.get<DioService>().footballDio,
      internetConnection: internetConnection,
    ),
    dependsOn: [LoggerService, DioService],
  );

  registerSingletonAsyncIfNotInitialized<PeriodicAPIService>(
    () async {
      final periodicAPI = PeriodicAPIService(
        logger: getIt.get<LoggerService>(),
      );
      if (enablePeriodicFetching) {
        periodicAPI.init();
      }
      return periodicAPI;
    },
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<BackgroundFetchService>(
    () async {
      final backgroundFetch = BackgroundFetchService(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
      );
      await backgroundFetch.init();
      return backgroundFetch;
    },
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<NotificationService>(
    () async {
      final notification = NotificationService(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
        api: getIt.get<APIService>(),
      );
      await notification.init();
      return notification;
    },
    dependsOn: [
      LoggerService,
      HiveService,
      LeagueStorageService,
      TeamStorageService,
      MatchStorageService,
      DioService,
      RemoteSettingsService,
      APIService,
    ],
  );

  registerSingletonAsyncIfNotInitialized<BalunNavigationBarService>(
    () async => BalunNavigationBarService(
      logger: getIt.get<LoggerService>(),
    ),
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<BalunNavigationBarBadgeService>(
    () async => BalunNavigationBarBadgeService(
      logger: getIt.get<LoggerService>(),
    ),
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<BalunScreenService>(
    () async => BalunScreenService(
      logger: getIt.get<LoggerService>(),
    ),
    dependsOn: [LoggerService, BalunNavigationBarService],
  );
}

void initializeBackgroundServices({
  required bool enableRemoteSettings,
  required bool useDioInterceptors,
}) {
  if (getIt.isRegistered<NotificationService>()) {
    return;
  }

  final internetConnection = InternetConnection.createInstance(
    triggerStream: Connectivity().onConnectivityChanged,
  );

  registerSingletonAsyncIfNotInitialized<LoggerService>(
    () async => LoggerService(),
  );

  registerSingletonAsyncIfNotInitialized<HiveService>(
    () async {
      final hive = HiveService(
        logger: getIt.get<LoggerService>(),
      );
      await hive.init();
      return hive;
    },
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<LeagueStorageService>(
    () async => LeagueStorageService(
      logger: getIt.get<LoggerService>(),
      hiveLeagues: getIt.get<HiveService>().leagues.values.toList(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<TeamStorageService>(
    () async => TeamStorageService(
      logger: getIt.get<LoggerService>(),
      hiveTeams: getIt.get<HiveService>().teams.values.toList(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<MatchStorageService>(
    () async => MatchStorageService(
      logger: getIt.get<LoggerService>(),
      hiveMatches: getIt.get<HiveService>().matches.values.toList(),
    ),
    dependsOn: [LoggerService, HiveService],
  );

  registerSingletonAsyncIfNotInitialized<DioService>(
    () async => DioService(
      logger: getIt.get<LoggerService>(),
      useInterceptors: useDioInterceptors,
    )..init(),
    dependsOn: [LoggerService],
  );

  registerSingletonAsyncIfNotInitialized<RemoteSettingsService>(
    () async {
      final remoteSettings = RemoteSettingsService(
        logger: getIt.get<LoggerService>(),
        dio: getIt.get<DioService>().remoteSettingsDio,
        internetConnection: internetConnection,
      );
      if (enableRemoteSettings) {
        await remoteSettings.init();
      }
      return remoteSettings;
    },
    dependsOn: [LoggerService, DioService],
  );

  registerSingletonAsyncIfNotInitialized<APIService>(
    () async => APIService(
      logger: getIt.get<LoggerService>(),
      dio: getIt.get<DioService>().footballDio,
      internetConnection: internetConnection,
    ),
    dependsOn: [LoggerService, DioService],
  );

  registerSingletonAsyncIfNotInitialized<NotificationService>(
    () async {
      final notification = NotificationService(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
        api: getIt.get<APIService>(),
      );
      await notification.init();
      return notification;
    },
    dependsOn: [
      LoggerService,
      HiveService,
      LeagueStorageService,
      TeamStorageService,
      MatchStorageService,
      DioService,
      RemoteSettingsService,
      APIService,
    ],
  );
}
