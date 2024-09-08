import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../services/api_service.dart';
import '../services/balun_navigation_bar_service.dart';
import '../services/balun_screen_service.dart';
import '../services/dio_service.dart';
import '../services/logger_service.dart';

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
      final dio = DioService(
        logger: getIt.get<LoggerService>(),
      );
      await dio.init();
      return dio;
    },
    dependsOn: [LoggerService],
  )
  ..registerSingletonAsync(
    () async => APIService(
      logger: getIt.get<LoggerService>(),
      noCacheDio: getIt.get<DioService>().noCacheDio,
      cacheDio: getIt.get<DioService>().cacheDio,
      internetConnection: InternetConnection(),
    ),
    dependsOn: [LoggerService, DioService],
  )
  ..registerSingletonAsync(
    () async => BalunNavigationBarService(
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
