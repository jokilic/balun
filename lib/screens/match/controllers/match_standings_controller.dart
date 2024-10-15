import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/standings/standing_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class MatchStandingsController extends ValueNotifier<BalunState<List<StandingResponse>>> {
  final LoggerService logger;
  final APIService api;

  MatchStandingsController({
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

  Future<void> getStandings({
    required int? leagueId,
    required String? season,
  }) async {
    if (leagueId == null || season == null) {
      value = Error(
        error: 'leagueIdOrSeasonNull'.tr(),
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getStandingsFromLeague(
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
      else if (response.standingsResponse!.response?.firstOrNull?.league != null) {
        fetched = true;
        value = Success(
          data: response.standingsResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
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
