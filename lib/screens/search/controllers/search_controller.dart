import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../models/sections/search_section.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import '../../../util/scrollable.dart';
import 'search_coaches_controller.dart';
import 'search_countries_controller.dart';
import 'search_leagues_controller.dart';
import 'search_players_controller.dart';
import 'search_teams_controller.dart';

class SearchController extends ValueNotifier<SearchSection> implements Disposable {
  final LoggerService logger;
  final APIService api;

  SearchController({
    required this.logger,
    required this.api,
  }) : super(SearchSection(searchSectionEnum: SearchSectionEnum.countries)) {
    textEditingController = TextEditingController();

    itemKeys = {
      for (final section in SearchSectionEnum.values) section.index: GlobalKey(),
    };
  }

  @override
  FutureOr onDispose() {
    textEditingController.dispose();
  }

  ///
  /// VARIABLES
  ///

  late final TextEditingController textEditingController;
  late final Map<int, GlobalKey> itemKeys;

  ///
  /// METHODS
  ///

  void updateState(SearchSection newSection) {
    if (value != newSection) {
      value = newSection;
      textEditingController.clear();

      animateActiveSectionTitle(
        itemKeys: itemKeys,
        newSectionIndex: newSection.searchSectionEnum.index,
      );
    }
  }

  void triggerSearch(String searchValue) {
    if (searchValue.isEmpty) {
      return;
    }

    switch (value) {
      ///
      /// COUNTRIES
      ///
      case SearchSection(searchSectionEnum: SearchSectionEnum.countries):
        getIt
            .get<SearchCountriesController>(
              instanceName: 'search',
            )
            .searchCountries(
              searchValue: searchValue,
            );
        break;

      ///
      /// LEAGUES
      ///
      case SearchSection(searchSectionEnum: SearchSectionEnum.leagues):
        getIt
            .get<SearchLeaguesController>(
              instanceName: 'search',
            )
            .searchLeagues(
              searchValue: searchValue,
            );
        break;

      ///
      /// TEAMS
      ///
      case SearchSection(searchSectionEnum: SearchSectionEnum.teams):
        getIt
            .get<SearchTeamsController>(
              instanceName: 'search',
            )
            .searchTeams(
              searchValue: searchValue,
            );
        break;

      ///
      /// PLAYERS
      ///
      case SearchSection(searchSectionEnum: SearchSectionEnum.players):
        getIt
            .get<SearchPlayersController>(
              instanceName: 'search',
            )
            .searchPlayers(
              searchValue: searchValue,
            );
        break;

      ///
      /// COACHES
      ///
      case SearchSection(searchSectionEnum: SearchSectionEnum.coaches):
        getIt
            .get<SearchCoachesController>(
              instanceName: 'search',
            )
            .searchCoaches(
              searchValue: searchValue,
            );
        break;
    }
  }
}
