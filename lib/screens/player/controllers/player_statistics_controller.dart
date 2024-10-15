import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/players/statistic/statistic.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

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
      }

      /// Response is not null, update to success state
      else if (response.playersResponse!.response?.firstOrNull?.statistics?.isNotEmpty ?? false) {
        fetchedSeason = season;
        value = Success(
          data: response.playersResponse!.response!.first.statistics!,
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
