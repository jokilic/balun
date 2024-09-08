import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'controllers/league_controller.dart';
import 'controllers/league_fixtures_controller.dart';
import 'controllers/league_season_controller.dart';
import 'controllers/league_section_controller.dart';
import 'controllers/league_standings_controller.dart';
import 'controllers/league_teams_controller.dart';
import 'controllers/league_top_assists_controller.dart';
import 'controllers/league_top_red_cards_controller.dart';
import 'controllers/league_top_scorers_controller.dart';
import 'controllers/league_top_yellow_cards_controller.dart';
import 'widgets/league_content.dart';

class LeagueScreen extends WatchingStatefulWidget {
  final int leagueId;
  final int season;

  const LeagueScreen({
    required this.leagueId,
    required this.season,
    required super.key,
  });

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<LeagueSectionController>(
      () => LeagueSectionController(
        logger: getIt.get<LoggerService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueTeamsController>(
      () => LeagueTeamsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueStandingsController>(
      () => LeagueStandingsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueFixturesController>(
      () => LeagueFixturesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueTopScorersController>(
      () => LeagueTopScorersController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueTopAssistsController>(
      () => LeagueTopAssistsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueTopYellowCardsController>(
      () => LeagueTopYellowCardsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueTopRedCardsController>(
      () => LeagueTopRedCardsController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueSeasonController>(
      () => LeagueSeasonController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
        section: getIt.get<LeagueSectionController>(
          instanceName: '${widget.leagueId}',
        ),
        leagueId: widget.leagueId,
        initialSeason: widget.season,
      ),
      instanceName: '${widget.leagueId}',
    );
    registerIfNotInitialized<LeagueController>(
      () => LeagueController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: '${widget.leagueId}',
      afterRegister: (controller) => controller.getLeague(
        leagueId: widget.leagueId,
      ),
    );
  }

  @override
  void dispose() {
    getIt
      ..unregister<LeagueSectionController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueTeamsController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueStandingsController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueFixturesController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueTopScorersController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueTopAssistsController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueTopYellowCardsController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueTopRedCardsController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueSeasonController>(
        instanceName: '${widget.leagueId}',
      )
      ..unregister<LeagueController>(
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
