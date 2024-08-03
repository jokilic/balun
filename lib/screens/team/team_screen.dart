import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'team_controller.dart';
import 'widgets/team_content.dart';

class TeamScreen extends WatchingStatefulWidget {
  final int teamId;

  const TeamScreen({
    required this.teamId,
  });

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    super.initState();

    getIt.registerLazySingleton(
      () => TeamController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.teamId}',
    );

    getIt
        .get<TeamController>(
          instanceName: '${widget.teamId}',
        )
        .getTeam(
          teamId: widget.teamId,
        );
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<TeamController>(
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
