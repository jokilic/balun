import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class TeamMatchesController extends ValueNotifier<BalunState<List<FixtureResponse>>> {
  final LoggerService logger;
  final APIService api;

  TeamMatchesController({
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

  Future<void> getFixturesFromTeam({
    required int? teamId,
    required int lastNumber,
    required int nextNumber,
  }) async {
    if (teamId == null) {
      value = Error(
        error: 'teamIdNull'.tr(),
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    /// Create two API calls
    final futureList = [
      api.getFixturesFromTeam(
        teamId: teamId!,
        lastNumber: lastNumber,
      ),
      api.getFixturesFromTeam(
        teamId: teamId,
        nextNumber: nextNumber,
      ),
    ];

    /// Call API requests
    final responses = await Future.wait(futureList);

    /// At least one successful request
    if (responses.any((response) => response.fixturesResponse != null) && responses.any((response) => response.error == null)) {
      /// Errors exist, update to error state
      if (responses.any((response) => response.fixturesResponse!.errors?.isNotEmpty)) {
        value = Error(
          error: responses.singleOrNull?.fixturesResponse!.errors!.toString(),
        );
      }
      /// Response is not null, update to success state
      else if (response.fixturesResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.fixturesResponse!.response!,
        );
      }
      /// Response is null, update to empty state
      else {
        fetched = true;
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
