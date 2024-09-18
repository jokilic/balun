import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/balun_navigation_bar.dart';
import 'countries_controller.dart';
import 'widgets/countries_app_bar.dart';
import 'widgets/countries_content.dart';

class CountriesScreen extends WatchingStatefulWidget {
  const CountriesScreen({required super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<CountriesController>(
      () => CountriesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'countries',
      afterRegister: (controller) => controller.getCountries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final countriesState = watchIt<CountriesController>(
      instanceName: 'countries',
    ).value;

    return Scaffold(
      bottomNavigationBar: BalunNavigationBar(),
      body: SafeArea(
        child: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: Column(
            children: [
              const SizedBox(height: 12),

              ///
              /// APP BAR
              ///
              CountriesAppBar(),
              const SizedBox(height: 8),

              ///
              /// CONTENT
              ///
              Expanded(
                child: Animate(
                  key: ValueKey(countriesState),
                  effects: const [
                    FadeEffect(
                      curve: Curves.easeIn,
                      duration: BalunConstants.animationDuration,
                    ),
                  ],
                  child: CountriesContent(
                    countriesState: countriesState,
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
