import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../services/api_service.dart';
import '../../../services/balun_navigation_bar_badge_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import '../../../util/state.dart';

class FixturesController extends ValueNotifier<BalunState<List<FixtureResponse>>> {
  final LoggerService logger;
  final APIService api;

  FixturesController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  /// Triggered when the user does a `pull-to-refresh`
  Future<void> onRefresh({
    required String dateString,
    required String currentDateString,
  }) async {
    /// Refresh only if the user is in current day
    if (dateString == currentDateString) {
      await getFixturesFromDate(
        dateString: dateString,
        withLoadingState: false,
      );
    }
  }

  Future<void> getFixturesFromDate({
    required String dateString,
    bool withLoadingState = true,
  }) async {
    /// Disable badge in [BalunNavigationBar]
    getIt.get<BalunNavigationBarBadgeService>().updateBadge(
      fixtures: [],
    );

    if (withLoadingState) {
      value = Loading();
    }

    final response = await api.getFixturesFromDate(
      dateString: dateString,
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
        final data = response.fixturesResponse!.response!;

        value = Success(
          data: data,
        );

        /// Update badge in [BalunNavigationBar]
        getIt.get<BalunNavigationBarBadgeService>().updateBadge(
              fixtures: data,
            );
      }

      /// Response is null, update to empty state
      else {
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

  /// Triggered periodically
  /// Doesn't update `state`
  /// Fetches new `data` and updates if everything was successful
  Future<void> getPeriodicFixturesFromDate({required String dateString}) async {
    /// Do the logic if we're already in [Success] `state`
    if (value is Success) {
      final response = await api.getFixturesFromDate(
        dateString: dateString,
      );

      /// Successful request
      if (response.fixturesResponse != null && response.error == null) {
        /// Response is not null, update to success state
        if (response.fixturesResponse!.response?.isNotEmpty ?? false) {
          final data = response.fixturesResponse!.response!;

          value = Success(
            data: data,
          );

          /// Update badge in [BalunNavigationBar]
          getIt.get<BalunNavigationBarBadgeService>().updateBadge(
                fixtures: data,
              );
        }
      }
    }
  }
}
