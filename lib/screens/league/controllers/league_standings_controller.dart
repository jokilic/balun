import 'package:flutter/material.dart';

import '../../../models/standings/league/league.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class LeagueStandingsController extends ValueNotifier<BalunState<League>> {
  final LoggerService logger;
  final APIService api;

  LeagueStandingsController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// VARIABLES
  ///

  int? fetchedSeason;

  ///
  /// METHODS
  ///

  Future<void> getStandingsFromLeagueAndSeason({
    required int? leagueId,
    required int? season,
  }) async {
    if (leagueId == null || season == null) {
      value = Error(
        error: 'Passed leagueId or season is null',
      );
    }

    if (fetchedSeason == season) {
      return;
    }

    value = Loading();

    final response = await api.getStandings(
      leagueId: leagueId!,
      season: season!,
    );

    /// Successful request
    if (response.standingsResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.standingsResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.standingsResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.standingsResponse!.response?.isNotEmpty ?? false) {
        fetchedSeason = season;
        value = Success(
          data: response.standingsResponse!.response!.first.league!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetchedSeason = season;
        value = Empty();
      }
    }

    /// Failed request
    if (response.standingsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}