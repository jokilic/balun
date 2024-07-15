import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../util/dependencies.dart';
import 'fixtures_controller.dart';
import 'widgets/fixtures_content.dart';

class FixturesScreen extends WatchingStatefulWidget {
  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  @override
  void dispose() {
    getIt.resetLazySingleton<FixturesController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fixturesState = watchIt<FixturesController>().value;

    return Scaffold(
      body: Animate(
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
    );
  }
}
