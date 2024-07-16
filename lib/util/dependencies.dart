import 'package:get_it/get_it.dart';

import '../screens/fixtures/fixtures_controller.dart';
import '../screens/match/controllers/match_controller.dart';
import '../screens/match/controllers/match_section_controller.dart';
import '../screens/team/team_controller.dart';
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

void initializeControllers() => getIt
  ..registerLazySingleton(
    () => FixturesController(
      logger: getIt.get<LoggerService>(),
      api: getIt.get<APIService>(),
    ),
  )
  ..registerLazySingleton(
    () => MatchController(
      logger: getIt.get<LoggerService>(),
      api: getIt.get<APIService>(),
    ),
  )
  ..registerLazySingleton(
    () => MatchSectionController(
      logger: getIt.get<LoggerService>(),
    ),
  )
  ..registerLazySingleton(
    () => TeamController(
      logger: getIt.get<LoggerService>(),
      api: getIt.get<APIService>(),
    ),
  );
