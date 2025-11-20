import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants.dart';
import 'status_list_tile_loading.dart';
import 'status_static_widget_list.dart';

class StatusLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    physics: const BouncingScrollPhysics(),
    children: [
      ...getStatusStaticWidgetList(context),

      Animate(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            3,
            (index) => StatusListTileLoading(),
          ),
        ),
      ),

      const SizedBox(height: 28),
    ],
  );
}
