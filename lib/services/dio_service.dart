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

  late final dio = Dio(
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
}
