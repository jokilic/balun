import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants.dart';
import '../util/env.dart';
import 'logger_service.dart';

///
/// Service which holds an instance of `Dio`
/// Used for networking
/// Contains methods that ease our networking logic
///

class DioService {
  final LoggerService logger;

  DioService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final Dio footballDio;
  late final Dio remoteSettingsDio;
  late final Dio youTubeSearchDio;
  late final Dio newsDio;

  ///
  /// INIT
  ///

  void init() {
    ///
    /// Initialize variables
    ///

    footballDio = Dio(
      BaseOptions(
        baseUrl: BalunConstants.apiFootballBaseUrl,
        headers: {
          'x-apisports-key': BalunConstants.apiFootballApiKey,
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    );

    remoteSettingsDio = Dio(
      BaseOptions(
        baseUrl: BalunConstants.remoteSettingsBaseUrl,
        validateStatus: (_) => true,
      ),
    );

    youTubeSearchDio = Dio(
      BaseOptions(
        baseUrl: BalunConstants.apiYouTubeDataBaseUrl,
        validateStatus: (_) => true,
      ),
    );

    newsDio = Dio(
      BaseOptions(
        baseUrl: BalunConstants.newsSearchBaseUrl,
        headers: {
          'x-access-key': Env.newsSearchApiKey,
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    );

    ///
    /// Add interceptors
    ///

    if (kDebugMode) {
      footballDio.interceptors.add(
        DioLoggerInterceptor(
          logger: logger,
        ),
      );

      remoteSettingsDio.interceptors.add(
        DioLoggerInterceptor(
          logger: logger,
        ),
      );

      youTubeSearchDio.interceptors.add(
        DioLoggerInterceptor(
          logger: logger,
        ),
      );

      newsDio.interceptors.add(
        DioLoggerInterceptor(
          logger: logger,
        ),
      );
    }
  }
}
