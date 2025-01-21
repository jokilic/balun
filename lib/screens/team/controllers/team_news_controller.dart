import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/news/news_result.dart';
import '../../../services/logger_service.dart';
import '../../../services/news_service.dart';
import '../../../util/state.dart';

class TeamNewsController extends ValueNotifier<BalunState<List<NewsResult>>> {
  final LoggerService logger;
  final NewsService news;

  TeamNewsController({
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

  Future<void> getNewsFromTeam({
    required String? teamName,
  }) async {
    if (teamName == null) {
      value = Error(
        error: 'teamNameNull'.tr(),
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await news.getNewsSearch(
      searchQuery: teamName!,
    );

    /// Successful request
    if (response.newsResponse != null && response.error == null) {
      /// Results are not empty, update to success state
      if (response.newsResponse!.results?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.newsResponse!.results!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.newsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
