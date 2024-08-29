import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/balun_navigation_bar.dart';
import 'controllers/search_coaches_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/search_countries_controller.dart';
import 'controllers/search_leagues_controller.dart';
import 'controllers/search_teams_controller.dart';
import 'widgets/search_active_section.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/search_sections.dart';

class SearchScreen extends WatchingStatefulWidget {
  const SearchScreen({required super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();

    if (!getIt.isRegistered<SearchController>(instanceName: 'search')) {
      getIt
        ..registerLazySingleton(
          () => SearchCountriesController(
            logger: getIt.get<LoggerService>(),
            api: getIt.get<APIService>(),
          ),
          instanceName: 'search',
        )
        ..registerLazySingleton(
          () => SearchLeaguesController(
            logger: getIt.get<LoggerService>(),
            api: getIt.get<APIService>(),
          ),
          instanceName: 'search',
        )
        ..registerLazySingleton(
          () => SearchTeamsController(
            logger: getIt.get<LoggerService>(),
            api: getIt.get<APIService>(),
          ),
          instanceName: 'search',
        )
        ..registerLazySingleton(
          () => SearchCoachesController(
            logger: getIt.get<LoggerService>(),
            api: getIt.get<APIService>(),
          ),
          instanceName: 'search',
        )
        ..registerLazySingleton(
          () => SearchController(
            logger: getIt.get<LoggerService>(),
            api: getIt.get<APIService>(),
          ),
          instanceName: 'search',
        );
    }
  }

  // @override
  // void dispose() {
  //   getIt
  //     ..unregister<SearchCountriesController>(
  //       instanceName: 'search',
  //     )
  //     ..unregister<SearchLeaguesController>(
  //       instanceName: 'search',
  //     )
  //     ..unregister<SearchTeamsController>(
  //       instanceName: 'search',
  //     )
  //     ..unregister<SearchCoachesController>(
  //       instanceName: 'search',
  //     )
  //     ..unregister<SearchController>(
  //       instanceName: 'search',
  //     );

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final searchSection = watchIt<SearchController>(
      instanceName: 'search',
    ).value;

    return Scaffold(
      bottomNavigationBar: BalunNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            ///
            /// SEARCH BAR
            ///
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: SearchBarWidget(
                onSubmitted: getIt
                    .get<SearchController>(
                      instanceName: 'search',
                    )
                    .triggerSearch,
              ),
            ),

            ///
            /// SEARCH SECTIONS
            ///
            SearchSections(
              activeSearchSection: searchSection,
              titlePressed: getIt
                  .get<SearchController>(
                    instanceName: 'search',
                  )
                  .updateState,
              controller: getIt
                  .get<SearchController>(
                    instanceName: 'search',
                  )
                  .controller,
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
    );
  }
}
