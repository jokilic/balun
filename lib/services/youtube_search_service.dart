import 'dart:async';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../constants.dart';
import '../models/youtube_search/youtube_search_response.dart';
import '../util/isolates.dart';
import 'logger_service.dart';

class YouTubeSearchService {
  final LoggerService logger;
  final Dio dio;
  final InternetConnection internetConnection;

  YouTubeSearchService({
    required this.logger,
    required this.dio,
    required this.internetConnection,
  });

  ///
  /// METHODS
  ///

  Future<({YouTubeSearchResponse? youTubeSearch, String? error})> getYouTubeVideoSearch({
    required String searchQuery,
    int maxResults = 5,
    String order = 'relevance',
    bool onlyEmbeddable = true,
  }) async {
    try {
      final response = await dio.get(
        '/search',
        queryParameters: {
          'part': 'snippet',
          'q': searchQuery,
          'type': 'video',
          'maxResults': maxResults,
          'order': order,
          'key': BalunConstants.apiYouTubeDataApiKey,
          'videoEmbeddable': onlyEmbeddable ? 'true' : 'any',
          'videoSyndicated': onlyEmbeddable ? 'true' : 'any',
        },
      );

      /// Handle status codes
      switch (response.statusCode) {
        /// Response is successful
        case 200:
        case 304:
          try {
            final parsedResponse = await computeYouTubeSearch(response.data);
            return (youTubeSearch: parsedResponse, error: null);
          } catch (e) {
            final error = 'API -> getYouTubeVideoSearch -> parsing error -> $e';
            logger.e(error);

            return (youTubeSearch: null, error: error);
          }

        /// Response is not successful
        default:
          final error = 'API -> getYouTubeVideoSearch -> StatusCode ${response.statusCode}';
          logger.e(error);

          return (youTubeSearch: null, error: error);
      }
    } catch (e) {
      final error = await handleCatch(
        methodName: 'getYouTubeVideoSearch',
        mainError: '$e',
      );

      return (youTubeSearch: null, error: error);
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
