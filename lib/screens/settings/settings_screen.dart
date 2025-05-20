import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants.dart';
import 'widgets/settings_app_bar.dart';
import 'widgets/settings_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required super.key,
  });

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
