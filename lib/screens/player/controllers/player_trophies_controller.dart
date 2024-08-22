import 'package:flutter/material.dart';

import '../../../models/trophies/trophy_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class PlayerTrophiesController extends ValueNotifier<BalunState<List<TrophyResponse>>> {
  final LoggerService logger;
  final APIService api;

  PlayerTrophiesController({
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

  Future<void> getPlayerTrophies({
    required int? playerId,
  }) async {
    if (playerId == null) {
      value = Error(
        error: 'Passed playerId is null',
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getTrophiesFromPlayer(
      playerId: playerId!,
    );

    /// Successful request
    if (response.trophiesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.trophiesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.trophiesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.trophiesResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.trophiesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.trophiesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
