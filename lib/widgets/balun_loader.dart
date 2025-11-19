import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../theme/icons.dart';
import '../theme/theme.dart';
import 'balun_image.dart';

class BalunLoader extends StatefulWidget {
  final Color? color;
  final double size;

  const BalunLoader({
    this.color,
    this.size = 40,
  });

  @override
  State<BalunLoader> createState() => _BalunLoaderState();
}

class _BalunLoaderState extends State<BalunLoader> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: BalunConstants.shimmerDuration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (_, child) => Transform.rotate(
      angle: controller.value * 2 * pi,
      child: BalunImage(
        imageUrl: BalunIcons.ball,
        height: widget.size,
        width: widget.size,
        color: widget.color ?? context.colors.primaryBackground,
      ),
    ),
  );
}
