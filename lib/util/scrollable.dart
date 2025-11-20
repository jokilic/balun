import 'package:flutter/material.dart';

import '../constants.dart';

void animateActiveFixtureDate({
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

void animateActiveSectionTitle({
  required Map<int, GlobalKey> itemKeys,
  required int newSectionIndex,
}) {
  final targetKey = itemKeys[newSectionIndex];
  final targetContext = targetKey?.currentContext;

  if (targetContext == null) {
    return;
  }

  Scrollable.ensureVisible(
    targetContext,
    duration: BalunConstants.animationDuration,
    curve: Curves.easeIn,
    alignment: 0.5,
  );
}
