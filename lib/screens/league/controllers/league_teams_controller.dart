import 'package:flutter/material.dart';

import '../../../models/teams/team_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class LeagueTeamsController extends ValueNotifier<BalunState<List<TeamResponse>>> {
  final LoggerService logger;
  final APIService api;

  LeagueTeamsController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// VARIABLES
  ///

  var fetched = false;

  ///
  /// METHODS
  ///

  Future<void> getTeamsFromLeagueAndSeason({
    required int? leagueId,
    required int? season,
  }) async {
    if (leagueId == null || season == null) {
      value = Error(
        error: 'Passed leagueId or season is null',
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getTeamsFromLeagueAndSeason(
      leagueId: leagueId!,
      season: season!,
    );

    /// Successful request
    if (response.teamsResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.teamsResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.teamsResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.teamsResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.teamsResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.teamsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
