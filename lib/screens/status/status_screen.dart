import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'status_controller.dart';
import 'widget/status_app_bar.dart';
import 'widget/status_content.dart';

class StatusScreen extends WatchingStatefulWidget {
  const StatusScreen({
    required super.key,
  });

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<StatusController>(
      () => StatusController(
        logger: getIt.get<LoggerService>(),
        api: getIt.get<APIService>(),
      ),
      instanceName: 'status',
      afterRegister: (controller) => controller.getStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusState = watchIt<StatusController>(
      instanceName: 'status',
    ).value;

    return Scaffold(
      body: SafeArea(
        child: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.longAnimationDuration,
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              ///
              /// APP BAR
              ///
              StatusAppBar(
                onPressed: Navigator.of(context).pop,
              ),
              const SizedBox(height: 8),

              ///
              /// CONTENT
              ///
              Expanded(
                child: Animate(
                  effects: const [
                    FadeEffect(
                      curve: Curves.easeIn,
                      duration: BalunConstants.animationDuration,
                    ),
                  ],
                  child: StatusContent(
                    statusState: statusState,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
