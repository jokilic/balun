import 'package:dio/dio.dart';

import '../constants.dart';
import '../util/env.dart';
import 'logger_service.dart';

///
/// Service which holds an instance of `Dio`
/// Used for networking
/// Contains methods that ease our networking logic
///

class DioService {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;

  DioService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final footballDio =
      Dio(
          BaseOptions(
            baseUrl: BalunConstants.rapidApiBaseUrl,
            headers: {
              'x-rapidapi-host': BalunConstants.rapidApiHost,
              'x-rapidapi-key': BalunConstants.rapidApiKey,
              'Content-Type': 'application/json',
            },
            validateStatus: (_) => true,
          ),
        )
        ..interceptors.add(
          DioLoggerInterceptor(
            logger: logger,
          ),
        );

  late final remoteSettingsDio =
      Dio(
          BaseOptions(
            baseUrl: BalunConstants.remoteSettingsBaseUrl,
            validateStatus: (_) => true,
          ),
        )
        ..interceptors.add(
          DioLoggerInterceptor(
            logger: logger,
          ),
        );

  late final youTubeSearchDio =
      Dio(
          BaseOptions(
            baseUrl: BalunConstants.apiYouTubeDataBaseUrl,
            validateStatus: (_) => true,
          ),
        )
        ..interceptors.add(
          DioLoggerInterceptor(
            logger: logger,
          ),
        );

  late final newsDio =
      Dio(
          BaseOptions(
            baseUrl: BalunConstants.newsSearchBaseUrl,
            headers: {
              'x-access-key': Env.newsSearchApiKey,
              'Content-Type': 'application/json',
            },
            validateStatus: (_) => true,
          ),
        )
        ..interceptors.add(
          DioLoggerInterceptor(
            logger: logger,
          ),
        );
}
