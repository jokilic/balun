import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class LeagueFixturesController extends ValueNotifier<BalunState<List<FixtureResponse>>> {
  final LoggerService logger;
  final APIService api;

  LeagueFixturesController({
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

  Future<void> getFixturesFromLeagueAndSeason({
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

    final response = await api.getFixturesFromLeagueAndSeason(
      leagueId: leagueId!,
      season: season!,
    );

    /// Successful request
    if (response.fixturesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.fixturesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.fixturesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.fixturesResponse!.response?.isNotEmpty ?? false) {
        fetchedSeason = season;
        value = Success(
          data: response.fixturesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetchedSeason = season;
        value = Empty();
      }
    }

    /// Failed request
    if (response.fixturesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
