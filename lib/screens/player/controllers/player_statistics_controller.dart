import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/players/statistic/statistic.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import '../../../util/state.dart';
import 'player_current_team_controller.dart';

class PlayerStatisticsController extends ValueNotifier<BalunState<List<Statistic>>> {
  final LoggerService logger;
  final APIService api;

  PlayerStatisticsController({
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

  Future<void> getPlayerStatistics({
    required int? playerId,
    required String? season,
  }) async {
    if (playerId == null || season == null) {
      value = Error(
        error: 'playerIdOrSeasonNull'.tr(),
      );
    }

    if (fetchedSeason == season) {
      return;
    }

    value = Loading();

    final response = await api.getPlayer(
      playerId: playerId!,
      season: season!,
    );

    /// Successful request
    if (response.playersResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.playersResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.playersResponse!.errors!.toString(),
        );

        /// Update current team to null, since error happened while fetching
        getIt
            .get<PlayerCurrentTeamController>(
              instanceName: '$playerId',
            )
            .updateState(null);
      }

      /// Response is not null, update to success state
      else if (response.playersResponse!.response?.firstOrNull?.statistics?.isNotEmpty ?? false) {
        fetchedSeason = season;
        value = Success(
          data: response.playersResponse!.response!.first.statistics!,
        );

        /// Update current team, since it's UI is updated dynamically
        getIt
            .get<PlayerCurrentTeamController>(
              instanceName: '$playerId',
            )
            .updateState(response.playersResponse!.response!.first.statistics?.firstOrNull?.team);
      }

      /// Response is null, update to empty state
      else {
        fetchedSeason = season;
        value = Empty();

        /// Update current team to null, since error happened while fetching
        getIt
            .get<PlayerCurrentTeamController>(
              instanceName: '$playerId',
            )
            .updateState(null);
      }
    }

    /// Failed request
    if (response.playersResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );

      /// Update current team to null, since error happened while fetching
      getIt
          .get<PlayerCurrentTeamController>(
            instanceName: '$playerId',
          )
          .updateState(null);
    }
  }
}
