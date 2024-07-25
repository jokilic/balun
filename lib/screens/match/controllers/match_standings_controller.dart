import 'package:flutter/material.dart';

import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class MatchStandingsController extends ValueNotifier<BalunState<bool>> {
  final LoggerService logger;
  final APIService api;

  MatchStandingsController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getStandings({
    required int? leagueId,
    required int? season,
  }) async {
    if (leagueId == null || season == null) {
      value = Error(
        error: 'Passed leagueId or season is null',
      );
    }

    value = Loading();

    final response = await api.getStandings(
      leagueId: leagueId!,
      season: season!,
    );

    /// Successful request
    // if (response.standingsResponse != null && response.error == null) {
    //   /// Errors exist, update to error state
    //   if (response.standingsResponse!.errors?.isNotEmpty ?? false) {
    //     value = Error(
    //       error: response.standingsResponse!.errors?.map((error) => error.bug).toString(),
    //     );
    //   }

    //   /// Response is not null, update to success state
    //   else if (response.standingsResponse!.response?.isNotEmpty ?? false) {
    //     value = Success(
    //       data: response.standingsResponse!.response!.first,
    //     );
    //   }

    //   /// Response is null, update to error state
    //   else {
    //     value = Error(
    //       error: 'Standings response is null',
    //     );
    //   }
    // }

    // /// Failed request
    // if (response.standingsResponse == null && response.error != null) {
    //   /// Error is not null, update to error state
    //   value = Error(
    //     error: response.error,
    //   );
    // }
  }
}
