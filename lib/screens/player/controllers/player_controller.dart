import 'package:flutter/material.dart';

import '../../../models/players/player_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import '../../../util/state.dart';
import 'player_current_team_controller.dart';

class PlayerController extends ValueNotifier<BalunState<PlayerResponse>> {
  final LoggerService logger;
  final APIService api;

  PlayerController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getPlayer({
    required int playerId,
    required String season,
  }) async {
    value = Loading();

    final response = await api.getPlayer(
      playerId: playerId,
      season: season,
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
      else if (response.playersResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.playersResponse!.response!.first,
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

  Future<void> getPlayerCurrentTeam({
    required int playerId,
    required String season,
  }) async {
    final response = await api.getPlayer(
      playerId: playerId,
      season: season,
    );

    /// Successful request
    if (response.playersResponse != null && response.error == null) {
      /// Errors exist
      if (response.playersResponse!.errors?.isNotEmpty ?? false) {
        /// Update current team to null, since error happened while fetching
        getIt
            .get<PlayerCurrentTeamController>(
              instanceName: '$playerId',
            )
            .updateState(null);
      }

      /// Response is not null
      else if (response.playersResponse!.response?.isNotEmpty ?? false) {
        /// Update current team, since it's UI is updated dynamically
        getIt
            .get<PlayerCurrentTeamController>(
              instanceName: '$playerId',
            )
            .updateState(response.playersResponse!.response!.first.statistics?.firstOrNull?.team);
      }

      /// Response is null
      else {
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
      /// Update current team to null, since error happened while fetching
      getIt
          .get<PlayerCurrentTeamController>(
            instanceName: '$playerId',
          )
          .updateState(null);
    }
  }
}
