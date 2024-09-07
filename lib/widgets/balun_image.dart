import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants.dart';
import '../theme/theme.dart';
import '../util/color.dart';

class BalunImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final double radius;

  const BalunImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.color,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) => imageUrl.contains('assets/')
      ? Image.asset(
          imageUrl,
          height: height,
          width: width,
          fit: fit,
        )
      : imageUrl.contains('.svg')
          ? CachedNetworkSVGImage(
              imageUrl,
              height: height,
              width: width,
              fit: fit,
              placeholder: BalunImagePlaceholder(
                height: height,
                width: width,
                radius: radius,
                color: color,
              ),
              errorWidget: BalunImageError(
                height: height,
                width: width,
                radius: radius,
                color: color,
              ),
            )
          : CachedNetworkImage(
              imageUrl: imageUrl,
              height: height,
              width: width,
              fit: fit,
              placeholder: (_, __) => BalunImagePlaceholder(
                height: height,
                width: width,
                radius: radius,
                color: color,
              ),
              errorWidget: (_, __, ___) => BalunImageError(
                height: height,
                width: width,
                radius: radius,
                color: color,
              ),
            );
}

class BalunImagePlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final Color? color;

  const BalunImagePlaceholder({
    required this.height,
    required this.width,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Animate(
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
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color ?? getRandomBalunColor(context),
          ),
        ),
      );
}

class BalunImageError extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final Color? color;

  const BalunImageError({
    required this.height,
    required this.width,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(radius),
          color: color ?? getRandomBalunColor(context),
        ),
      );
}
