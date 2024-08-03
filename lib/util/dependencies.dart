import 'package:get_it/get_it.dart';

import '../services/api_service.dart';
import '../services/dio_service.dart';
import '../services/logger_service.dart';

final getIt = GetIt.instance;

void initializeServices() => getIt
  ..registerSingletonAsync(
    () async => LoggerService(),
  )
  ..registerSingletonAsync(
    () async => DioService(
      getIt.get<LoggerService>(),
    ),
    dependsOn: [LoggerService],
  )
  ..registerSingletonAsync(
    () async => APIService(
      logger: getIt.get<LoggerService>(),
      dio: getIt.get<DioService>().dio,
    ),
    dependsOn: [LoggerService, DioService],
  );
