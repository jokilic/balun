import 'dart:async';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../models/news/news_response.dart';
import '../util/isolates.dart';
import 'logger_service.dart';

class NewsService {
  final LoggerService logger;
  final Dio dio;
  final InternetConnection internetConnection;

  NewsService({
    required this.logger,
    required this.dio,
    required this.internetConnection,
  });

  ///
  /// METHODS
  ///

  Future<({NewsResponse? newsResponse, String? error})> getNewsSearch({
    required String searchQuery,
  }) async {
    try {
      final response = await dio.get(
        '/latest',
        queryParameters: {
          'q': searchQuery,
          'language': 'hr, en',
          'excludefield':
              'keywords, creator, video_url, content, pubDateTZ, source_id, source_priority, language, country, category, ai_tag, sentiment, sentiment_stats, ai_region, ai_org',
          'removeduplicate': '1',
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeNews(response.data);
            return (newsResponse: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getNewsSearch -> parsing error -> $e';
            logger.e(error);

            return (newsResponse: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getNewsSearch -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (newsResponse: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getNewsSearch',
        mainError: '$e',
      );

      return (newsResponse: null, error: error);
    }
  }

  /// Checks for internet connection and returns error message
  Future<String> handleCatch({
    required String methodName,
    required String mainError,
  }) async {
    final hasInternet = await internetConnection.hasInternetAccess;
    final generatedError = hasInternet ? mainError : 'Internet connection error';
    final error = 'API -> $methodName -> catch -> $generatedError';
    logger.e(error);
    return error;
  }
}
