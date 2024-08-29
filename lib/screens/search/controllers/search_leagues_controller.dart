import 'package:flutter/material.dart';

import '../../../models/search/search_leagues/search_league_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class SearchLeaguesController extends ValueNotifier<BalunState<List<SearchLeagueResponse>>> {
  final LoggerService logger;
  final APIService api;

  SearchLeaguesController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> searchLeagues({
    required String searchValue,
  }) async {
    value = Loading();

    final response = await api.searchLeagues(
      searchValue: searchValue,
    );

    /// Successful request
    if (response.searchLeaguesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.searchLeaguesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.searchLeaguesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.searchLeaguesResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.searchLeaguesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.searchLeaguesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
