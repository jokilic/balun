import 'package:flutter/material.dart';

import '../constants.dart';

void animateScrollableTitles({
  required PageController pageController,
  required double viewportFraction,
  required int targetPage,
}) => WidgetsBinding.instance.addPostFrameCallback(
  (_) {
    if (!pageController.hasClients || !pageController.position.hasViewportDimension) {
      return;
    }

    final viewportDimension = pageController.position.viewportDimension;
    final pageWidth = viewportFraction * viewportDimension;
    final targetOffset = targetPage * pageWidth;

    pageController.animateTo(
      targetOffset.clamp(
        pageController.position.minScrollExtent,
        pageController.position.maxScrollExtent,
      ),
      duration: BalunConstants.animationDuration,
      curve: Curves.easeIn,
    );
  },
);
