import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'controllers/player_controller.dart';
import 'controllers/player_season_controller.dart';
import 'controllers/player_section_controller.dart';
import 'controllers/player_statistics_controller.dart';
import 'controllers/player_transfers_controller.dart';
import 'widgets/player_content.dart';

class PlayerScreen extends WatchingStatefulWidget {
  final int playerId;
  final int season;

  const PlayerScreen({
    required this.playerId,
    required this.season,
    required super.key,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();

    getIt
      ..registerLazySingleton(
        () => PlayerSectionController(
          logger: getIt.get<LoggerService>(),
        ),
        instanceName: '${widget.playerId}',
      )
      ..registerLazySingleton(
        () => PlayerStatisticsController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
        ),
        instanceName: '${widget.playerId}',
      )
      ..registerLazySingleton(
        () => PlayerTransfersController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
        ),
        instanceName: '${widget.playerId}',
      )
      ..registerLazySingleton(
        () => PlayerSeasonController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
          section: getIt.get<PlayerSectionController>(
            instanceName: '${widget.playerId}',
          ),
          playerId: widget.playerId,
          initialSeason: widget.season,
        ),
        instanceName: '${widget.playerId}',
      )
      ..registerLazySingleton(
        () => PlayerController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
        ),
        instanceName: '${widget.playerId}',
      );

    getIt
        .get<PlayerController>(
          instanceName: '${widget.playerId}',
        )
        .getPlayer(
          playerId: widget.playerId,
          season: widget.season,
        );
  }

  @override
  void dispose() {
    getIt
      ..unregister<PlayerSectionController>(
        instanceName: '${widget.playerId}',
      )
      ..unregister<PlayerStatisticsController>(
        instanceName: '${widget.playerId}',
      )
      ..unregister<PlayerTransfersController>(
        instanceName: '${widget.playerId}',
      )
      ..unregister<PlayerSeasonController>(
        instanceName: '${widget.playerId}',
      )
      ..unregister<PlayerController>(
        instanceName: '${widget.playerId}',
      );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerState = watchIt<PlayerController>(
      instanceName: '${widget.playerId}',
    ).value;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Animate(
          key: ValueKey(playerState),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: PlayerContent(
            playerState: playerState,
          ),
        ),
      ),
    );
  }
}
