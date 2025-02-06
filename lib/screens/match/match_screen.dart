import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../services/periodic_api_service.dart';
import '../../services/youtube_search_service.dart';
import '../../util/dependencies.dart';
import '../../util/state.dart';
import 'controllers/match_controller.dart';
import 'controllers/match_h2h_controller.dart';
import 'controllers/match_highlights_controller.dart';
import 'controllers/match_section_controller.dart';
import 'controllers/match_standings_controller.dart';
import 'widgets/match_content.dart';

class MatchScreen extends WatchingStatefulWidget {
  final int matchId;

  const MatchScreen({
    required this.matchId,
    required super.key,
  });

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  void initState() {
    super.initState();

    getIt.get<PeriodicAPIService>().matchId = widget.matchId;

    registerIfNotInitialized<MatchSectionController>(
      () => MatchSectionController(
        logger: getIt.get<LoggerService>(),
      ),
      instanceName: '${widget.matchId}',
    );
    registerIfNotInitialized<MatchHighlightsController>(
      () => MatchHighlightsController(
        logger: getIt.get<LoggerService>(),
        youTubeSearch: getIt.get<YouTubeSearchService>(),
      ),
      instanceName: '${widget.matchId}',
    );
    registerIfNotInitialized<MatchStandingsController>(
      () => MatchStandingsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.matchId}',
    );
    registerIfNotInitialized<MatchHead2HeadController>(
      () => MatchHead2HeadController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.matchId}',
    );
    registerIfNotInitialized<MatchController>(
      () => MatchController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.matchId}',
      afterRegister: (controller) => controller.getMatch(
        matchId: widget.matchId,
      ),
    );
  }

  @override
  void dispose() {
    getIt.get<PeriodicAPIService>().matchId = null;

    getIt
      ..unregister<MatchController>(
        instanceName: '${widget.matchId}',
      )
      ..unregister<MatchSectionController>(
        instanceName: '${widget.matchId}',
      )
      ..unregister<MatchHighlightsController>(
        instanceName: '${widget.matchId}',
      )
      ..unregister<MatchStandingsController>(
        instanceName: '${widget.matchId}',
      )
      ..unregister<MatchHead2HeadController>(
        instanceName: '${widget.matchId}',
      );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchState = watchIt<MatchController>(
      instanceName: '${widget.matchId}',
    ).value;

    return VisibilityDetector(
      key: widget.key ?? ValueKey(widget.matchId),
      onVisibilityChanged: (info) => getIt.get<PeriodicAPIService>().shouldFetchMatch = info.visibleFraction > 0,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Animate(
            key: matchState is Success ? null : ValueKey(matchState),
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: BalunConstants.animationDuration,
              ),
            ],
            child: MatchContent(
              matchState: matchState,
              onRefresh: () => getIt
                  .get<MatchController>(
                    instanceName: '${widget.matchId}',
                  )
                  .getMatch(
                    matchId: widget.matchId,
                    withLoadingState: false,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
