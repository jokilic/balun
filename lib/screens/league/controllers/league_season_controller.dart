import 'package:flutter/material.dart';

import '../../../models/league_section.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import 'league_section_controller.dart';
import 'league_teams_controller.dart';

class LeagueSeasonController extends ValueNotifier<int> {
  final LoggerService logger;
  final APIService api;
  final LeagueSectionController section;
  final int leagueId;
  final int initialSeason;

  LeagueSeasonController({
    required this.logger,
    required this.api,
    required this.section,
    required this.leagueId,
    required this.initialSeason,
  }) : super(initialSeason);

  ///
  /// METHODS
  ///

  void updateState(int? newSeason) {
    if (newSeason != null && value != newSeason) {
      /// Set state to new value
      value = newSeason;

      /// Fetch new data, depending on active section
      switch (section.value) {
        case LeagueSection(leagueSectionEnum: LeagueSectionEnum.teams):
          getIt
              .get<LeagueTeamsController>(
                instanceName: '$leagueId',
              )
              .getTeamsFromLeagueAndSeason(
                leagueId: leagueId,
                season: newSeason,
              );
          break;
        default:
      }
    }
  }
}
