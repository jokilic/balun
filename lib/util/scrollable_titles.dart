import 'package:flutter/material.dart';

import '../constants.dart';

void animateScrollableTitles({
  required ScrollController scrollController,
  required double viewportFraction,
  required int targetPage,
}) => WidgetsBinding.instance.addPostFrameCallback(
  (_) {
    if (!scrollController.hasClients || !scrollController.position.hasViewportDimension) {
      return;
    }

    final viewportDimension = scrollController.position.viewportDimension;
    final pageWidth = viewportFraction * viewportDimension;
    final targetOffset = targetPage * pageWidth;

    scrollController.animateTo(
      targetOffset.clamp(
        scrollController.position.minScrollExtent,
        scrollController.position.maxScrollExtent,
      ),
      duration: BalunConstants.animationDuration,
      curve: Curves.easeIn,
    );
  },
);
