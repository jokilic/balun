import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../models/league_section.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import 'league_fixtures_controller.dart';
import 'league_section_controller.dart';
import 'league_standings_controller.dart';
import 'league_teams_controller.dart';
import 'league_top_assists_controller.dart';
import 'league_top_red_cards_controller.dart';
import 'league_top_scorers_controller.dart';
import 'league_top_yellow_cards_controller.dart';

class LeagueSeasonController extends ValueNotifier<String> implements Disposable {
  final LoggerService logger;
  final APIService api;
  final LeagueSectionController section;
  final int leagueId;
  final String initialSeason;

  LeagueSeasonController({
    required this.logger,
    required this.api,
    required this.section,
    required this.leagueId,
    required this.initialSeason,
  }) : super(initialSeason) {
    controller = PageController(
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

  void scrollToInitialSeason({required List<String>? seasonsYears}) {
    if (seasonsYears?.isNotEmpty ?? false) {
      controller.animateToPage(
        seasonsYears!.indexOf(initialSeason),
        duration: BalunConstants.animationDuration,
        curve: Curves.easeIn,
      );
    }
  }

  void updateState(String? newSeason) {
    if (newSeason != null && value != newSeason) {
      /// Set state to new value
      value = newSeason;

      /// Fetch new data, depending on active section
      switch (section.value) {
        ///
        /// TEAMS
        ///
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

        ///
        /// STANDINGS
        ///
        case LeagueSection(leagueSectionEnum: LeagueSectionEnum.standings):
          getIt
              .get<LeagueStandingsController>(
                instanceName: '$leagueId',
              )
              .getStandingsFromLeagueAndSeason(
                leagueId: leagueId,
                season: newSeason,
              );
          break;

        ///
        /// FIXTURES
        ///
        case LeagueSection(leagueSectionEnum: LeagueSectionEnum.fixtures):
          getIt
              .get<LeagueFixturesController>(
                instanceName: '$leagueId',
              )
              .getFixturesFromLeagueAndSeason(
                leagueId: leagueId,
                season: newSeason,
              );
          break;

        ///
        /// TOP SCORERS
        ///
        case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topScorers):
          getIt
              .get<LeagueTopScorersController>(
                instanceName: '$leagueId',
              )
              .getTopScorers(
                leagueId: leagueId,
                season: newSeason,
              );
          break;

        ///
        /// TOP ASSISTS
        ///
        case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topAssists):
          getIt
              .get<LeagueTopAssistsController>(
                instanceName: '$leagueId',
              )
              .getTopAssists(
                leagueId: leagueId,
                season: newSeason,
              );
          break;

        ///
        /// TOP YELLOW CARDS
        ///
        case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topYellowCards):
          getIt
              .get<LeagueTopYellowCardsController>(
                instanceName: '$leagueId',
              )
              .getTopYellowCards(
                leagueId: leagueId,
                season: newSeason,
              );
          break;

        ///
        /// TOP RED CARDS
        ///
        case LeagueSection(leagueSectionEnum: LeagueSectionEnum.topRedCards):
          getIt
              .get<LeagueTopRedCardsController>(
                instanceName: '$leagueId',
              )
              .getTopRedCards(
                leagueId: leagueId,
                season: newSeason,
              );
          break;
      }
    }
  }
}
