import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants.dart';
import 'widgets/about_app_bar.dart';
import 'widgets/about_content.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                ///
                /// APP BAR
                ///
                AboutAppBar(
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
                    child: AboutContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
