import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants.dart';
import 'leagues_list_tile_loading.dart';

class LeaguesLoading extends StatelessWidget {
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
          itemBuilder: (_, __) => LeaguesListTileLoading(),
          separatorBuilder: (_, __) => const SizedBox(height: 4),
        ),
      );
}
