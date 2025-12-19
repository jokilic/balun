import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';
import 'main_info/league_main_info_loading.dart';
import 'sliding_info/league_sliding_info_loading.dart';

class LeagueLoading extends StatefulWidget {
  @override
  State<LeagueLoading> createState() => _LeagueLoadingState();
}

class _LeagueLoadingState extends State<LeagueLoading> {
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
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
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
          child: LeagueMainInfoLoading(),
        ),

        ///
        /// SLIDING CONTENT
        ///
        SlidingUpPanel(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40),
          ),
          color: context.colors.slidingInfoPanelBackground,
          scrollController: scrollController,
          minHeight: screenHeight * 0.425,
          maxHeight: screenHeight - 144,
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
            child: LeagueSlidingInfoLoading(
              scrollController: scrollController,
            ),
          ),
        ),
      ],
    );
  }
}
