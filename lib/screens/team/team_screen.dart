import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'controllers/team_coaches_controller.dart';
import 'controllers/team_controller.dart';
import 'controllers/team_leagues_controller.dart';
import 'controllers/team_players_controller.dart';
import 'controllers/team_season_controller.dart';
import 'controllers/team_section_controller.dart';
import 'controllers/team_standings_controller.dart';
import 'controllers/team_transfers_controller.dart';
import 'widgets/team_content.dart';

class TeamScreen extends WatchingStatefulWidget {
  final int teamId;
  final String season;

  const TeamScreen({
    required this.teamId,
    required this.season,
    required super.key,
  });

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<TeamSectionController>(
      () => TeamSectionController(
        logger: getIt.get<LoggerService>(),
      ),
      instanceName: '${widget.teamId}',
    );
    registerIfNotInitialized<TeamLeaguesController>(
      () => TeamLeaguesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.teamId}',
    );
    registerIfNotInitialized<TeamStandingsController>(
      () => TeamStandingsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.teamId}',
    );
    registerIfNotInitialized<TeamCoachesController>(
      () => TeamCoachesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.teamId}',
    );
    registerIfNotInitialized<TeamPlayersController>(
      () => TeamPlayersController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.teamId}',
    );
    registerIfNotInitialized<TeamTransfersController>(
      () => TeamTransfersController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.teamId}',
    );
    registerIfNotInitialized<TeamSeasonController>(
      () => TeamSeasonController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
        section: getIt.get<TeamSectionController>(
          instanceName: '${widget.teamId}',
        ),
        teamId: widget.teamId,
        initialSeason: widget.season,
      ),
      instanceName: '${widget.teamId}',
    );
    registerIfNotInitialized<TeamController>(
      () => TeamController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.teamId}',
      afterRegister: (controller) => controller.getTeam(
        teamId: widget.teamId,
      ),
    );
  }

  @override
  void dispose() {
    getIt
      ..unregister<TeamSectionController>(
        instanceName: '${widget.teamId}',
      )
      ..unregister<TeamLeaguesController>(
        instanceName: '${widget.teamId}',
      )
      ..unregister<TeamStandingsController>(
        instanceName: '${widget.teamId}',
      )
      ..unregister<TeamCoachesController>(
        instanceName: '${widget.teamId}',
      )
      ..unregister<TeamPlayersController>(
        instanceName: '${widget.teamId}',
      )
      ..unregister<TeamTransfersController>(
        instanceName: '${widget.teamId}',
      )
      ..unregister<TeamSeasonController>(
        instanceName: '${widget.teamId}',
      )
      ..unregister<TeamController>(
        instanceName: '${widget.teamId}',
      );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamState = watchIt<TeamController>(
      instanceName: '${widget.teamId}',
    ).value;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Animate(
          key: ValueKey(teamState),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: TeamContent(
            teamState: teamState,
          ),
        ),
      ),
    );
  }
}
