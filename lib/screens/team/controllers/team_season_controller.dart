import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../models/sections/team_section.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import '../../../util/team_seasons.dart';
import 'team_section_controller.dart';
import 'team_standings_controller.dart';

class TeamSeasonController extends ValueNotifier<String> implements Disposable {
  final LoggerService logger;
  final APIService api;
  final TeamSectionController section;
  final int teamId;
  final String initialSeason;

  TeamSeasonController({
    required this.logger,
    required this.api,
    required this.section,
    required this.teamId,
    required this.initialSeason,
  }) : super(initialSeason) {
    final seasonInt = int.tryParse(initialSeason);

    controller = PageController(
      initialPage: seasonInt != null ? generateYearList().indexOf(seasonInt) : 0,
      viewportFraction: 0.4,
    );
  }

  @override
  FutureOr onDispose() {
    controller.dispose();
  }

  ///
  /// VARIABLES
  ///

  late final PageController controller;

  ///
  /// METHODS
  ///

  void updateState(String? newSeason) {
    if (newSeason != null && value != newSeason) {
      /// Set state to new value
      value = newSeason;

      /// Fetch new data, depending on active section
      switch (section.value) {
        ///
        /// STANDINGS
        ///
        case TeamSection(teamSectionEnum: TeamSectionEnum.standings):
          getIt
              .get<TeamStandingsController>(
                instanceName: '$teamId',
              )
              .getStandingsFromTeam(
                teamId: teamId,
                season: newSeason,
              );
          break;
      }
    }
  }
}
