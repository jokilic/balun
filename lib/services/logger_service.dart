import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerService {
  ///
  /// VARIABLES
  ///

  late final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 50,
      noBoxingByDefault: true,
    ),
  );

  ///
  /// METHODS
  ///

  /// Trace log, grey color
  void t(value) => logger.t(value);

  /// 🐛 Debug log, blue color
  void d(value) => logger.d(value);

  /// 💡 Info log, light blue color
  void i(value) => logger.i(value);

  /// ⚠️ Warning log, orange color
  void w(value) => logger.w(value);

  /// ⛔ Error log, red color
  void e(value) => logger.e(value);

  /// 👾 Fatal error, purple color
  void f(value) => logger.f(value);

  /// Logs JSON responses with proper formatting
  void logJson(String data, {bool isError = false}) {
    final object = json.decode(data);
    final prettyString = const JsonEncoder.withIndent('  ').convert(object);
    isError ? logger.e(prettyString) : logger.t(prettyString);
  }
}

class DioLoggerInterceptor implements Interceptor {
  final LoggerService logger;

  DioLoggerInterceptor({
    required this.logger,
  });

  ///
  /// METHODS
  ///

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) => handler.next(options);

  @override
  void onError(DioException exception, ErrorInterceptorHandler handler) {
    final endpoint = '${exception.requestOptions.baseUrl}${exception.requestOptions.path}';
    final httpMethod = exception.requestOptions.method;
    final statusCode = '${exception.response?.statusCode}';
    final error = exception.message;
    final responseError = '${exception.response?.data}';
    final requestData = '${exception.requestOptions.data}';

    logger
      ..e('❌ ERROR FETCHING RESPONSE ❌')
      ..e('--------------------')
      ..e('Endpoint: $endpoint')
      ..e('HTTP Method: $httpMethod')
      ..e('Status code: $statusCode')
      ..e('Error: $error')
      ..e('ResponseError: $responseError')
      ..e('Request:')
      ..logJson(requestData, isError: true)
      ..e('--------------------\n');

    return handler.next(exception);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final endpoint = '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    final httpMethod = response.requestOptions.method;
    final statusCode = '${response.statusCode}';
    final requestData = response.requestOptions.data as String?;
    final queryParameters = jsonEncode(response.requestOptions.queryParameters);
    final jsonResponse = jsonEncode(response.data);

    logger
      ..t('RESPONSE SUCCESSFULLY FETCHED ✅')
      ..t('--------------------')
      ..t('Endpoint: $endpoint')
      ..t('HTTP Method: $httpMethod')
      ..t('Status code: $statusCode');

    if (requestData != null) {
      logger
        ..t('Request:')
        ..logJson(requestData);
    }

    if (queryParameters.isNotEmpty) {
      logger
        ..t('Query parameters:')
        ..logJson(queryParameters);
    }

    logger
      ..t('Response:')
      ..logJson(jsonResponse)
      ..t('--------------------\n');

    return handler.next(response);
  }
}
