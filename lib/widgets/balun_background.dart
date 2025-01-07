import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';
import 'balun_image/balun_image.dart';

class IconPosition {
  final double x;
  final double y;
  final double rotation;

  IconPosition(this.x, this.y, this.rotation);
}

class BalunBackground extends StatefulWidget {
  final Size screenSize;
  final double iconSize;
  final double padding;
  final Color iconColor;
  final double opacity;

  const BalunBackground({
    required this.screenSize,
    required this.iconColor,
    this.iconSize = 80,
    this.padding = 8,
    this.opacity = 0.1,
  });

  @override
  State<BalunBackground> createState() => _BalunBackgroundState();
}

class _BalunBackgroundState extends State<BalunBackground> {
  late final List<IconPosition> positions;

  bool isOverlapping({
    required IconPosition position,
    required List<IconPosition> placedIcons,
    required double totalSize,
  }) {
    for (final placed in placedIcons) {
      final dx = position.x - placed.x;
      final dy = position.y - placed.y;
      final distance = sqrt(dx * dx + dy * dy);

      if (distance < totalSize) {
        return true;
      }
    }

    return false;
  }

  List<IconPosition> generateNonOverlappingPositions({
    required double height,
    required double width,
  }) {
    /// Fixed seed for consistent layout
    final random = Random();
    final positions = <IconPosition>[];
    final totalSize = widget.iconSize + (widget.padding * 2);

    /// Calculate approximate grid
    final cols = (width / totalSize).floor();
    final rows = (height / totalSize).floor();

    /// Try to place icons with maximum attempts
    final maxAttempts = cols * rows * 10;
    var attempts = 0;

    while (attempts < maxAttempts) {
      final x = random.nextDouble() * (width - widget.iconSize);
      final y = random.nextDouble() * (height - widget.iconSize);
      final rotation = random.nextDouble() * pi * 2;

      final newPosition = IconPosition(x, y, rotation);

      final overlapping = isOverlapping(
        position: newPosition,
        placedIcons: positions,
        totalSize: totalSize,
      );

      if (!overlapping) {
        positions.add(newPosition);
      }

      attempts++;
    }

    return positions;
  }

  @override
  void initState() {
    super.initState();

    positions = generateNonOverlappingPositions(
      height: widget.screenSize.height,
      width: widget.screenSize.width,
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        color: context.colors.greenish,
        child: Stack(
          children: positions
              .map(
                (pos) => Positioned(
                  left: pos.x,
                  top: pos.y,
                  child: Transform.rotate(
                    angle: pos.rotation,
                    child: Opacity(
                      opacity: widget.opacity,
                      child: BalunImage(
                        imageUrl: BalunIcons.splashIcon,
                        height: widget.iconSize,
                        width: widget.iconSize,
                        color: widget.iconColor,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
