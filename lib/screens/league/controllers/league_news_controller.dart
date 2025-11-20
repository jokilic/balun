import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/news/news_result.dart';
import '../../../services/logger_service.dart';
import '../../../services/news_service.dart';
import '../../../util/state.dart';

class LeagueNewsController extends ValueNotifier<BalunState<List<NewsResult>>> {
  final LoggerService logger;
  final NewsService news;

  LeagueNewsController({
    required this.logger,
    required this.news,
  }) : super(Initial());

  ///
  /// VARIABLES
  ///

  var fetched = false;

  ///
  /// METHODS
  ///

  Future<void> getNewsFromLeague({
    required String? leagueName,
  }) async {
    if (leagueName == null) {
      value = Error(
        error: 'leagueNameNull'.tr(),
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final leagueNameCountryResponse = await news.getNewsSearch(
      searchQuery: '$leagueName football',
    );

    /// Successful request
    if (leagueNameCountryResponse.newsResponse != null && leagueNameCountryResponse.error == null) {
      /// Results are not empty, update to success state
      if (leagueNameCountryResponse.newsResponse!.results?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: leagueNameCountryResponse.newsResponse!.results!,
        );
      }
      /// Response is null, try to search only `leagueName`
      else {
        final leagueNameResponse = await news.getNewsSearch(
          searchQuery: leagueName!,
        );

        /// Successful request
        if (leagueNameResponse.newsResponse != null && leagueNameResponse.error == null) {
          /// Results are not empty, update to success state
          if (leagueNameResponse.newsResponse!.results?.isNotEmpty ?? false) {
            fetched = true;
            value = Success(
              data: leagueNameResponse.newsResponse!.results!,
            );
          }
          /// Response is null, update to empty state
          else {
            fetched = true;
            value = Empty();
          }
        }

        /// Failed request
        if (leagueNameResponse.newsResponse == null && leagueNameResponse.error != null) {
          /// Error is not null, update to error state
          value = Error(
            error: leagueNameResponse.error,
          );
        }
      }
    }

    /// Failed request
    if (leagueNameCountryResponse.newsResponse == null && leagueNameCountryResponse.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: leagueNameCountryResponse.error,
      );
    }
  }
}
