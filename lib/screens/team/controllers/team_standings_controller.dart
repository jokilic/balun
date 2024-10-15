import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/standings/standing_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class TeamStandingsController extends ValueNotifier<BalunState<List<StandingResponse>>> {
  final LoggerService logger;
  final APIService api;

  TeamStandingsController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// VARIABLES
  ///

  String? fetchedSeason;

  ///
  /// METHODS
  ///

  Future<void> getStandingsFromTeam({
    required int? teamId,
    required String? season,
  }) async {
    if (teamId == null || season == null) {
      value = Error(
        error: 'teamIdOrSeasonNull'.tr(),
      );
    }

    if (fetchedSeason == season) {
      return;
    }

    value = Loading();

    final response = await api.getStandingsFromTeam(
      teamId: teamId!,
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
          data: response.standingsResponse!.response!,
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
