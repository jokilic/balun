import 'package:flutter/material.dart';

class CustomPageScrollPhysics extends PageScrollPhysics {
  final double viewportFraction;

  const CustomPageScrollPhysics({
    required this.viewportFraction,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  CustomPageScrollPhysics applyTo(ScrollPhysics? ancestor) => CustomPageScrollPhysics(
        viewportFraction: viewportFraction,
        parent: buildParent(ancestor),
      );

  double getPageOffset(int page) => page * viewportFraction;
}
