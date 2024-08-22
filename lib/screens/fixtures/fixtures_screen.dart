import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/balun_navigation_bar.dart';
import 'controllers/fixtures_controller.dart';
import 'controllers/fixtures_date_controller.dart';
import 'widgets/fixtures_content.dart';

class FixturesScreen extends WatchingStatefulWidget {
  const FixturesScreen({required super.key});

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  late final DateTime now;

  @override
  void initState() {
    super.initState();

    now = DateTime.now();

    if (!getIt.isRegistered<FixturesController>(instanceName: 'fixtures')) {
      getIt
        ..registerLazySingleton(
          () => FixturesController(
            logger: getIt.get<LoggerService>(),
            api: getIt.get<APIService>(),
          ),
          instanceName: 'fixtures',
        )
        ..registerLazySingleton(
          () => FixturesDateController(
            logger: getIt.get<LoggerService>(),
            now: now,
          ),
          instanceName: 'fixtures',
        );

      getIt
          .get<FixturesController>(
            instanceName: 'fixtures',
          )
          .getFixtures();
    }
  }

  // @override
  // void dispose() {
  //   getIt
  //     ..unregister<FixturesController>(
  //       instanceName: 'fixtures',
  //     )
  //     ..unregister<FixturesDateController>(
  //       instanceName: 'fixtures',
  //     );

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final fixturesState = watchIt<FixturesController>(
      instanceName: 'fixtures',
    ).value;

    return Scaffold(
      bottomNavigationBar: BalunNavigationBar(),
      body: SafeArea(
        child: Animate(
          key: ValueKey(fixturesState),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: FixturesContent(
            fixturesState: fixturesState,
            now: now,
          ),
        ),
      ),
    );
  }
}
