import 'package:flutter/material.dart';

import '../screens/countries/countries_screen.dart';
import '../screens/fixtures/controllers/fixtures_date_controller.dart';
import '../screens/fixtures/fixtures_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../util/dependencies.dart';
import '../util/fixtures.dart';
import '../util/scrollable_titles.dart';
import '../widgets/balun_loader.dart';
import 'balun_navigation_bar_service.dart';
import 'logger_service.dart';

class BalunScreenService extends ValueNotifier<Widget> {
  final LoggerService logger;

  BalunScreenService({
    required this.logger,
  }) : super(
         const Scaffold(
           body: Center(
             child: BalunLoader(),
           ),
         ),
       ) {
    changeScreen(
      getIt.get<BalunNavigationBarService>().value,
    );
  }

  ///
  /// METHODS
  ///

  void changeScreen(BalunNavigationBarEnum newNavigationValue) {
    value = switch (newNavigationValue) {
      BalunNavigationBarEnum.fixtures => const FixturesScreen(
        key: ValueKey('fixtures'),
      ),
      BalunNavigationBarEnum.countries => const CountriesScreen(
        key: ValueKey('countries'),
      ),
      BalunNavigationBarEnum.search => const SearchScreen(
        key: ValueKey('search'),
      ),
      BalunNavigationBarEnum.settings => const SettingsScreen(
        key: ValueKey('settings'),
      ),
    };

    /// `Fixtures` are active, reanimate date picker
    if (newNavigationValue == BalunNavigationBarEnum.fixtures) {
      if (getIt.isRegistered<FixturesDateController>(instanceName: 'fixtures')) {
        final fixturesDateController = getIt.get<FixturesDateController>(
          instanceName: 'fixtures',
        );

        animateScrollableTitles(
          pageController: fixturesDateController.controller,
          viewportFraction: fixturesDateController.viewportFraction,
          targetPage: getPageForActiveDate(
            dates: fixturesDateController.dates,
            value: fixturesDateController.value,
          ),
        );
      }
    }
  }
}
