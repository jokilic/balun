import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../services/api_service.dart';
import '../services/balun_navigation_bar_badge_service.dart';
import '../services/balun_navigation_bar_service.dart';
import '../services/balun_screen_service.dart';
import '../services/dio_service.dart';
import '../services/hive_service.dart';
import '../services/league_storage_service.dart';
import '../services/logger_service.dart';
import '../services/news_service.dart';
import '../services/package_info_service.dart';
import '../services/periodic_api_service.dart';
import '../services/remote_settings_service.dart';
import '../services/team_storage_service.dart';
import '../services/youtube_search_service.dart';

final getIt = GetIt.instance;

/// Registers a class if it's not already initialized
/// Optionally runs a function with newly registered class
void registerIfNotInitialized<T extends Object>(
  T Function() factoryFunc, {
  required String instanceName,
  void Function(T controller)? afterRegister,
}) {
  if (!getIt.isRegistered<T>(instanceName: instanceName)) {
    getIt.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
    );

    if (afterRegister != null) {
      final instance = getIt.get<T>(instanceName: instanceName);
      afterRegister(instance);
    }
  }
}

void initializeServices({
  required bool enableRemoteSettings,
  required bool enablePeriodicFetching,
}) {
  final internetConnection = InternetConnection();

  getIt
    ..registerSingletonAsync(
      () async => LoggerService(),
    )
    ..registerSingletonAsync(
      () async {
        final packageInfo = PackageInfoService(
          logger: getIt.get<LoggerService>(),
        );
        await packageInfo.init();
        return packageInfo;
      },
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async {
        final hive = HiveService(
          logger: getIt.get<LoggerService>(),
        );
        await hive.init();
        return hive;
      },
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async => LeagueStorageService(
        logger: getIt.get<LoggerService>(),
        hiveLeagues: getIt.get<HiveService>().leagues.values.toList(),
      ),
      dependsOn: [LoggerService, HiveService],
    )
    ..registerSingletonAsync(
      () async => TeamStorageService(
        logger: getIt.get<LoggerService>(),
        hiveTeams: getIt.get<HiveService>().teams.values.toList(),
      ),
      dependsOn: [LoggerService, HiveService],
    )
    ..registerSingletonAsync(
      () async => DioService(
        logger: getIt.get<LoggerService>(),
      ),
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
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
    )
    ..registerSingletonAsync(
      () async => YouTubeSearchService(
        logger: getIt.get<LoggerService>(),
        dio: getIt.get<DioService>().youTubeSearchDio,
        internetConnection: internetConnection,
      ),
      dependsOn: [LoggerService, DioService],
    )
    ..registerSingletonAsync(
      () async => NewsService(
        logger: getIt.get<LoggerService>(),
        dio: getIt.get<DioService>().newsDio,
        internetConnection: internetConnection,
      ),
      dependsOn: [LoggerService, DioService],
    )
    ..registerSingletonAsync(
      () async => APIService(
        logger: getIt.get<LoggerService>(),
        dio: getIt.get<DioService>().footballDio,
        internetConnection: internetConnection,
      ),
      dependsOn: [LoggerService, DioService],
    )
    ..registerSingletonAsync(
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
    )
    ..registerSingletonAsync(
      () async => BalunNavigationBarService(
        logger: getIt.get<LoggerService>(),
      ),
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async => BalunNavigationBarBadgeService(
        logger: getIt.get<LoggerService>(),
      ),
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async => BalunScreenService(
        logger: getIt.get<LoggerService>(),
      ),
      dependsOn: [LoggerService, BalunNavigationBarService],
    );
}
