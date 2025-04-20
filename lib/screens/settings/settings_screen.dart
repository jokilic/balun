import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import 'settings_controller.dart';
import 'widgets/settings_app_bar.dart';
import 'widgets/settings_content.dart';

class SettingsScreen extends WatchingStatefulWidget {
  const SettingsScreen({
    required super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<SettingsController>(
      () => SettingsController(
        logger: getIt.get<LoggerService>(),
      ),
      instanceName: 'settings',
    );
  }

  @override
  void dispose() {
    getIt.unregister<SettingsController>(
      instanceName: 'settings',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Animate(
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: BalunConstants.longAnimationDuration,
              ),
            ],
            child: Column(
              children: [
                const SizedBox(height: 12),

                ///
                /// APP BAR
                ///
                SettingsAppBar(
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
                    child: SettingsContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
