import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class TeamMatchesController extends ValueNotifier<BalunState<({List<FixtureResponse> upcomingFixtures, List<FixtureResponse> playedFixtures})>> {
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
      return;
    }

    if (fetched) {
      return;
    }

    value = Loading();

    /// Create two API calls
    final futureList = [
      /// Upcoming
      api.getFixturesFromTeam(
        teamId: teamId,
        nextNumber: nextNumber,
      ),

      /// Played
      api.getFixturesFromTeam(
        teamId: teamId,
        lastNumber: lastNumber,
      ),
    ];

    /// Call API requests
    final responses = await Future.wait(futureList);

    final upcomingResponse = responses.firstOrNull;
    final playedResponse = responses.lastOrNull;

    final errors = <String>[];

    List<FixtureResponse>? upcoming;
    List<FixtureResponse>? played;

    /// Handle upcoming response
    if (upcomingResponse != null && upcomingResponse.fixturesResponse != null && upcomingResponse.error == null) {
      /// Errors exist, update to error state
      if (upcomingResponse.fixturesResponse!.errors?.isNotEmpty ?? false) {
        errors.add(
          upcomingResponse.fixturesResponse!.errors!.toString(),
        );
      }
      /// Response is not null, update to success state
      else if (upcomingResponse.fixturesResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        upcoming = upcomingResponse.fixturesResponse!.response;
      }
    }

    /// Handle played response
    if (playedResponse != null && playedResponse.fixturesResponse != null && playedResponse.error == null) {
      /// Errors exist, update to error state
      if (playedResponse.fixturesResponse!.errors?.isNotEmpty ?? false) {
        errors.add(
          playedResponse.fixturesResponse!.errors!.toString(),
        );
      }
      /// Response is not null, update to success state
      else if (playedResponse.fixturesResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        played = playedResponse.fixturesResponse!.response;
      }
    }

    /// Update `state`
    value = Success(
      data: (
        upcomingFixtures: upcoming ?? [],
        playedFixtures: played ?? [],
      ),
    );

    /// Handle failures
    if ((upcomingResponse?.fixturesResponse == null && upcomingResponse?.error != null) || playedResponse?.fixturesResponse == null && playedResponse?.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: errors.toString(),
      );
    }
  }
}
