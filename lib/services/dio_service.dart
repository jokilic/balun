import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

import '../constants.dart';
import '../util/env.dart';
import '../util/path.dart';
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

  late final Dio noCacheDio;
  late final Dio cacheDio;

  ///
  /// METHODS
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    final cacheOptions = CacheOptions(
      store: HiveCacheStore(directory?.path),
      policy: CachePolicy.forceCache,
      maxStale: BalunConstants.cacheDuration,
    );

    noCacheDio = Dio(
      BaseOptions(
        baseUrl: BalunConstants.baseUrl,
        headers: {
          'x-apisports-key': Env.apiFootballApiKey,
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    )..interceptors.add(
        DioLoggerInterceptor(
          logger: logger,
          isCached: false,
        ),
      );

    cacheDio = Dio(
      BaseOptions(
        baseUrl: BalunConstants.baseUrl,
        headers: {
          'x-apisports-key': Env.apiFootballApiKey,
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    )
      ..interceptors.add(
        DioLoggerInterceptor(
          logger: logger,
          isCached: true,
        ),
      )
      ..interceptors.add(
        DioCacheInterceptor(options: cacheOptions),
      );
  }
}
