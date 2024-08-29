import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../theme/theme.dart';

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
          ? SvgPicture.network(
              imageUrl,
              height: height,
              width: width,
              fit: fit,
            )
          : CachedNetworkImage(
              imageUrl: imageUrl,
              height: height,
              width: width,
              fit: fit,
              placeholder: (_, __) => Animate(
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
                    color: color ?? context.colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(radius),
                  color: color ?? context.colors.black.withOpacity(0.25),
                ),
              ),
            );
}
