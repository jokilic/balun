import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/date_time.dart';
import '../../util/dependencies.dart';
import '../../widgets/balun_navigation_bar.dart';
import 'controllers/fixtures_controller.dart';
import 'controllers/fixtures_date_controller.dart';
import 'widgets/fixtures_content.dart';
import 'widgets/fixtures_date_picker.dart';

class FixturesScreen extends WatchingStatefulWidget {
  const FixturesScreen({required super.key});

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  late final DateTime currentDate;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    currentDate = DateTime(now.year, now.month, now.day);

    registerIfNotInitialized<FixturesDateController>(
      () => FixturesDateController(
        logger: getIt.get<LoggerService>(),
        currentDate: currentDate,
      ),
      instanceName: 'fixtures',
    );
    registerIfNotInitialized<FixturesController>(
      () => FixturesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'fixtures',
      afterRegister: (controller) => controller.getFixturesFromDate(
        dateString: getDateForBackend(
          getIt
              .get<FixturesDateController>(
                instanceName: 'fixtures',
              )
              .value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fixturesState = watchIt<FixturesController>(
      instanceName: 'fixtures',
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
              const SizedBox(height: 16),

              ///
              /// DATE PICKER
              ///
              FixturesDatePicker(
                currentDate: currentDate,
              ),
              const SizedBox(height: 12),

              ///
              /// CONTENT
              ///
              Expanded(
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
