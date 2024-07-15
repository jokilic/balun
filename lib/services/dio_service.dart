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

  DioService(this.logger)

  ///
  /// INIT
  ///

  {
    dio = Dio(
      BaseOptions(
        baseUrl: BalunEndpoints.baseUrl,
        headers: {
          'x-apisports-key': Env.apiFootballApiKey,
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    )..interceptors.add(
        DioLoggerInterceptor(logger),
      );
  }

  ///
  /// VARIABLES
  ///

  late final Dio dio;
}
