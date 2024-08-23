import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'leagues_controller.dart';
import 'widgets/leagues_app_bar.dart';
import 'widgets/leagues_content.dart';

class LeaguesScreen extends WatchingStatefulWidget {
  final String country;

  const LeaguesScreen({
    required this.country,
    required super.key,
  });

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  @override
  void initState() {
    super.initState();

    getIt.registerLazySingleton(
      () => LeaguesController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'leagues',
    );

    getIt
        .get<LeaguesController>(
          instanceName: 'leagues',
        )
        .getLeaguesFromCountry(
          country: widget.country,
        );
  }

  @override
  void dispose() {
    getIt.unregister<LeaguesController>(
      instanceName: 'leagues',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leaguesState = watchIt<LeaguesController>(
      instanceName: 'leagues',
    ).value;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ///
            /// APP BAR
            ///
            LeaguesAppBar(
              onPressed: Navigator.of(context).pop,
              country: widget.country,
            ),
            const SizedBox(height: 16),

            ///
            /// CONTENT
            ///
            Expanded(
              child: Animate(
                key: ValueKey(leaguesState),
                effects: const [
                  FadeEffect(
                    curve: Curves.easeIn,
                    duration: BalunConstants.animationDuration,
                  ),
                ],
                child: LeaguesContent(
                  leaguesState: leaguesState,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
