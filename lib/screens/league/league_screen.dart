import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'controllers/league_controller.dart';
import 'controllers/league_section_controller.dart';
import 'controllers/league_teams_controller.dart';
import 'widgets/league_content.dart';

class LeagueScreen extends WatchingStatefulWidget {
  final int leagueId;

  const LeagueScreen({
    required this.leagueId,
    required super.key,
  });

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  void initState() {
    super.initState();

    getIt
      ..registerLazySingleton(
        () => LeagueSectionController(
          logger: getIt.get<LoggerService>(),
        ),
        instanceName: '${widget.leagueId}',
      )
      ..registerLazySingleton(
        () => LeagueTeamsController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
        ),
        instanceName: '${widget.leagueId}',
      )
      ..registerLazySingleton(
        () => LeagueController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
          section: getIt.get<LeagueSectionController>(
            instanceName: '${widget.leagueId}',
          ),
          teams: getIt.get<LeagueTeamsController>(
            instanceName: '${widget.leagueId}',
          ),
        ),
        instanceName: '${widget.leagueId}',
      );

    Future.wait(
      [
        getIt
            .get<LeagueController>(
              instanceName: '${widget.leagueId}',
            )
            .getLeague(
              leagueId: widget.leagueId,
            ),
        getIt
            .get<LeagueController>(
              instanceName: '${widget.leagueId}',
            )
            .getSlidingInfoData(
              leagueId: widget.leagueId,
              season: 2023,
            ),
      ],
    );
  }

  @override
  void dispose() {
    getIt
      ..unregister<LeagueController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueSectionController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueTeamsController>(
        instanceName: '${widget.leagueId}',
      );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leagueState = watchIt<LeagueController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Animate(
          key: ValueKey(leagueState),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: LeagueContent(
            leagueState: leagueState,
          ),
        ),
      ),
    );
  }
}
