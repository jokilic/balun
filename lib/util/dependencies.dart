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
import '../services/periodic_api_service.dart';
import '../services/team_storage_service.dart';

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

void initializeServices() => getIt
  ..registerSingletonAsync(
    () async => LoggerService(),
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
    () async => APIService(
      logger: getIt.get<LoggerService>(),
      dio: getIt.get<DioService>().dio,
      internetConnection: InternetConnection(),
    ),
    dependsOn: [LoggerService, DioService],
  )
  ..registerSingletonAsync(
    () async => PeriodicAPIService(
      logger: getIt.get<LoggerService>(),
    )..init(),
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
