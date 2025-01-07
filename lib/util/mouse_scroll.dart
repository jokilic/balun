import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Triggered when scrolling with mouse in [PageView] widget
void handlePageViewMouseScroll({
  required PointerScrollEvent event,
  required PageController pageController,
}) {
  final newOffset = pageController.offset + event.delta.dy;

  pageController.animateTo(
    newOffset.clamp(
      0.0,
      pageController.position.maxScrollExtent,
    ),
    duration: BalunConstants.animationDuration,
    curve: Curves.easeIn,
  );
}
