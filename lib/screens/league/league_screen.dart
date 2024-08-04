import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'controllers/league_controller.dart';
import 'widgets/league_content.dart';

class LeagueScreen extends WatchingStatefulWidget {
  final int leagueId;

  const LeagueScreen({
    required this.leagueId,
    super.key,
  });

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  void initState() {
    super.initState();

    getIt.registerLazySingleton(
      () => LeagueController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );

    getIt
        .get<LeagueController>(
          instanceName: '${widget.leagueId}',
        )
        .getLeague(
          leagueId: widget.leagueId,
        );
  }

  @override
  void dispose() {
    getIt.unregister<LeagueController>(
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
