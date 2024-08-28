import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'controllers/coach_controller.dart';
import 'controllers/coach_section_controller.dart';
import 'controllers/coach_sidelined_controller.dart';
import 'widgets/coach_content.dart';

class CoachScreen extends WatchingStatefulWidget {
  final int coachId;

  const CoachScreen({
    required this.coachId,
    required super.key,
  });

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  @override
  void initState() {
    super.initState();

    getIt
      ..registerLazySingleton(
        () => CoachSectionController(
          logger: getIt.get<LoggerService>(),
        ),
        instanceName: '${widget.coachId}',
      )
      ..registerLazySingleton(
        () => CoachSidelinedController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
        ),
        instanceName: '${widget.coachId}',
      )
      ..registerLazySingleton(
        () => CoachController(
          logger: getIt.get<LoggerService>(),
          api: getIt.get<APIService>(),
        ),
        instanceName: '${widget.coachId}',
      );

    getIt
        .get<CoachController>(
          instanceName: '${widget.coachId}',
        )
        .getCoach(
          coachId: widget.coachId,
        );
  }

  @override
  void dispose() {
    getIt
      ..unregister<CoachSectionController>(
        instanceName: '${widget.coachId}',
      )
      ..unregister<CoachSidelinedController>(
        instanceName: '${widget.coachId}',
      )
      ..unregister<CoachController>(
        instanceName: '${widget.coachId}',
      );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coachState = watchIt<CoachController>(
      instanceName: '${widget.coachId}',
    ).value;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Animate(
          key: ValueKey(coachState),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: CoachContent(
            coachState: coachState,
          ),
        ),
      ),
    );
  }
}
