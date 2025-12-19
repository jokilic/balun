import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';
import 'main_info/coach_main_info_loading.dart';
import 'sliding_info/coach_sliding_info_loading.dart';

class CoachLoading extends StatefulWidget {
  @override
  State<CoachLoading> createState() => _CoachLoadingState();
}

class _CoachLoadingState extends State<CoachLoading> {
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
          child: CoachMainInfoLoading(),
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
          minHeight: screenHeight * 0.45,
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
            child: CoachSlidingInfoLoading(
              scrollController: scrollController,
            ),
          ),
        ),
      ],
    );
  }
}
