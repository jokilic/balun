import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../models/search_section.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import 'search_coaches_controller.dart';
import 'search_countries_controller.dart';
import 'search_leagues_controller.dart';
import 'search_teams_controller.dart';

class SearchController extends ValueNotifier<SearchSection> implements Disposable {
  final LoggerService logger;
  final APIService api;

  SearchController({
    required this.logger,
    required this.api,
  }) : super(SearchSection(searchSectionEnum: SearchSectionEnum.countries)) {
    const viewportFraction = 0.4;

    pageController = PageController(
      viewportFraction: viewportFraction,
    );

    textEditingController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        const pageOffset = 0 * viewportFraction;
        const centeringOffset = (1 - viewportFraction) / 2;

        pageController
            .animateToPage(
              0,
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
            )
            .then(
              (_) => pageController.animateTo(
                (pageOffset + centeringOffset) * pageController.position.viewportDimension,
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
              ),
            );
      },
    );
  }

  @override
  FutureOr onDispose() {
    pageController.dispose();
    textEditingController.dispose();
  }

  ///
  /// VARIABLES
  ///

  late final PageController pageController;
  late final TextEditingController textEditingController;

  ///
  /// METHODS
  ///

  void updateState(SearchSection newSection) {
    if (value != newSection) {
      value = newSection;
    }
  }

  void triggerSearch(String searchValue) {
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
