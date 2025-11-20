import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../util/string.dart';
import 'controllers/search_coaches_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/search_countries_controller.dart';
import 'controllers/search_leagues_controller.dart';
import 'controllers/search_players_controller.dart';
import 'controllers/search_teams_controller.dart';
import 'widgets/search_active_section.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/search_sections.dart';

class SearchScreen extends WatchingStatefulWidget {
  const SearchScreen({
    required super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<SearchCountriesController>(
      () => SearchCountriesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'search',
    );
    registerIfNotInitialized<SearchLeaguesController>(
      () => SearchLeaguesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'search',
    );
    registerIfNotInitialized<SearchTeamsController>(
      () => SearchTeamsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'search',
    );
    registerIfNotInitialized<SearchPlayersController>(
      () => SearchPlayersController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'search',
    );
    registerIfNotInitialized<SearchCoachesController>(
      () => SearchCoachesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'search',
    );
    registerIfNotInitialized<SearchController>(
      () => SearchController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'search',
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchSection = watchIt<SearchController>(
      instanceName: 'search',
    ).value;

    return Scaffold(
      body: SafeArea(
        child: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.longAnimationDuration,
            ),
          ],
          child: Column(
            children: [
              ///
              /// SEARCH BAR
              ///
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: SearchBarWidget(
                  onSubmitted: (value) => getIt
                      .get<SearchController>(
                        instanceName: 'search',
                      )
                      .triggerSearch(
                        replaceSpecialSymbolsWithStandardLetters(
                          value.trim(),
                        ),
                      ),
                ),
              ),

              ///
              /// SEARCH SECTIONS
              ///
              SearchSections(
                itemKeys: getIt
                    .get<SearchController>(
                      instanceName: 'search',
                    )
                    .itemKeys,
                activeSearchSection: searchSection,
                titlePressed: getIt
                    .get<SearchController>(
                      instanceName: 'search',
                    )
                    .updateState,
              ),

              ///
              /// ACTIVE SECTION
              ///
              Expanded(
                child: Animate(
                  key: ValueKey(searchSection),
                  effects: const [
                    FadeEffect(
                      curve: Curves.easeIn,
                      duration: BalunConstants.animationDuration,
                    ),
                  ],
                  child: SearchActiveSection(
                    searchSection: searchSection,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
