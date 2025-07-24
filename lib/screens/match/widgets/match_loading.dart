import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';
import 'main_info/match_main_info_loading.dart';
import 'sliding_info/match_sliding_info_loading.dart';

class MatchLoading extends StatefulWidget {
  @override
  State<MatchLoading> createState() => _MatchLoadingState();
}

class _MatchLoadingState extends State<MatchLoading> {
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
        child: MatchMainInfoLoading(),
      ),
      SlidingUpPanel(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        scrollController: scrollController,
        color: context.colors.primaryBackground,
        minHeight: 400,
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
          child: MatchSlidingInfoLoading(
            scrollController: scrollController,
          ),
        ),
      ),
    ],
  );
}
