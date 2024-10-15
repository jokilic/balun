import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/players/player_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class LeagueTopScorersController extends ValueNotifier<BalunState<List<PlayerResponse>>> {
  final LoggerService logger;
  final APIService api;

  LeagueTopScorersController({
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

  Future<void> getTopScorers({
    required int? leagueId,
    required String? season,
  }) async {
    if (leagueId == null || season == null) {
      value = Error(
        error: 'leagueIdOrSeasonNull'.tr(),
      );
    }

    if (fetchedSeason == season) {
      return;
    }

    value = Loading();

    final response = await api.getTopScorers(
      leagueId: leagueId!,
      season: season!,
    );

    /// Successful request
    if (response.playersResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.playersResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.playersResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.playersResponse!.response?.isNotEmpty ?? false) {
        fetchedSeason = season;
        value = Success(
          data: response.playersResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetchedSeason = season;
        value = Empty();
      }
    }

    /// Failed request
    if (response.playersResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
