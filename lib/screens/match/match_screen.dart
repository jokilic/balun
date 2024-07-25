import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../util/dependencies.dart';
import 'controllers/match_controller.dart';
import 'controllers/match_section_controller.dart';
import 'controllers/match_standings_controller.dart';
import 'widgets/match_content.dart';

class MatchScreen extends WatchingStatefulWidget {
  final int matchId;

  const MatchScreen({
    required this.matchId,
  });

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<MatchController>().getMatch(
          matchId: widget.matchId,
        );
  }

  @override
  void dispose() {
    getIt
      ..resetLazySingleton<MatchController>()
      ..resetLazySingleton<MatchSectionController>()
      ..resetLazySingleton<MatchStandingsController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchState = watchIt<MatchController>().value;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Animate(
          key: ValueKey(matchState),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: MatchContent(
            matchState: matchState,
          ),
        ),
      ),
    );
  }
}
