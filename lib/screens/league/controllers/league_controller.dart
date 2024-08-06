import 'package:flutter/material.dart';

import '../../../models/league_section.dart';
import '../../../models/leagues/league_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';
import 'league_section_controller.dart';
import 'league_teams_controller.dart';

class LeagueController extends ValueNotifier<BalunState<LeagueResponse>> {
  final LoggerService logger;
  final APIService api;
  final LeagueSectionController section;
  final LeagueTeamsController teams;

  LeagueController({
    required this.logger,
    required this.api,
    required this.section,
    required this.teams,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getSlidingInfoData({
    int? leagueId,
    int? season,
  }) async {
    switch (section.value) {
      case LeagueSection(leagueSectionEnum: LeagueSectionEnum.teams):
        await teams.getTeamsFromLeagueAndSeason(
          leagueId: leagueId,
          season: season,
        );
        break;

      case LeagueSection(leagueSectionEnum: LeagueSectionEnum.standings):
      case LeagueSection(leagueSectionEnum: LeagueSectionEnum.fixtures):
      case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topScorers):
      case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topAssists):
      case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topYellowCards):
      case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topRedCards):
    }
  }

  Future<void> getLeague({
    required int leagueId,
  }) async {
    value = Loading();

    final response = await api.getLeague(
      leagueId: leagueId,
    );

    /// Successful request
    if (response.leaguesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.leaguesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.leaguesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.leaguesResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.leaguesResponse!.response!.first,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.leaguesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
