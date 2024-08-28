import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';
import 'main_info/player_main_info_loading.dart';
import 'sliding_info/player_sliding_info_loading.dart';

class PlayerLoading extends StatefulWidget {
  @override
  State<PlayerLoading> createState() => _PlayerLoadingState();
}

class _PlayerLoadingState extends State<PlayerLoading> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          ///
          /// TOP CONTENT
          ///
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
            child: PlayerMainInfoLoading(),
          ),

          ///
          /// SLIDING CONTENT
          ///
          SlidingUpPanel(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            scrollController: scrollController,
            color: context.colors.white,
            minHeight: 352,
            maxHeight: MediaQuery.sizeOf(context).height - 144,
            panelBuilder: () => Animate(
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
              child: PlayerSlidingInfoLoading(
                scrollController: scrollController,
              ),
            ),
          ),
        ],
      );
}
