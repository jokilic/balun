import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../util/env.dart';
import '../util/path.dart';
import 'logger_service.dart';

///
/// Service which holds an instance of `Dio`
/// Used for networking
/// Contains methods that ease our networking logic
///

class DioService extends ValueNotifier<int?> {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;

  DioService({
    required this.logger,
  }) : super(null);

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
        baseUrl: BalunEndpoints.baseUrl,
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
          isCached: false,
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) => handler.next(options),
          onResponse: (response, handler) {
            updateRemainingRequests(
              headers: response.headers,
            );
            return handler.next(response);
          },
          onError: (error, handler) {
            updateRemainingRequests(
              headers: error.response?.headers,
            );
            return handler.next(error);
          },
        ),
      );

    cacheDio = Dio(
      BaseOptions(
        baseUrl: BalunEndpoints.baseUrl,
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
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) => handler.next(options),
          onResponse: (response, handler) {
            updateRemainingRequests(
              headers: response.headers,
            );
            return handler.next(response);
          },
          onError: (error, handler) {
            updateRemainingRequests(
              headers: error.response?.headers,
            );
            return handler.next(error);
          },
        ),
      );
  }

  void updateRemainingRequests({required Headers? headers}) {
    if (headers != null) {
      final remainingRequests = headers.value(
        'x-ratelimit-requests-remaining',
      );

      if (remainingRequests != null) {
        value = int.tryParse(remainingRequests);
      }
    }
  }
}
