import 'package:flutter/material.dart';

import '../../../models/search/search_teams/search_team_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class SearchTeamsController extends ValueNotifier<BalunState<List<SearchTeamResponse>>> {
  final LoggerService logger;
  final APIService api;

  SearchTeamsController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> searchTeams({
    required String searchValue,
  }) async {
    value = Loading();

    final response = await api.searchTeams(
      searchValue: searchValue,
    );

    /// Successful request
    if (response.searchTeamsResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.searchTeamsResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.searchTeamsResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.searchTeamsResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.searchTeamsResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.searchTeamsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
