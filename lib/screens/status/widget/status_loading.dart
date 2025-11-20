import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants.dart';

class StatusLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Animate(
    onPlay: (controller) => controller.loop(
      reverse: true,
      min: 0.6,
    ),
    effects: const [
      FadeEffect(
        curve: Curves.easeIn,
        duration: BalunConstants.shimmerDuration,
      ),
    ],
    child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: 12,
      // TODO: Proper loading here
      itemBuilder: (_, __) => Container(
        height: 40,
        width: 40,
        color: Colors.red,
      ),
      // itemBuilder: (_, __) => CountriesListTileLoading(),
      separatorBuilder: (_, __) => const SizedBox(height: 4),
    ),
  );
}
