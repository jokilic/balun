import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants.dart';
import '../services/remote_settings_service.dart';
import '../theme/icons.dart';
import '../theme/theme.dart';
import '../util/color.dart';
import '../util/dependencies.dart';

const httpHeaders = {
  'User-Agent': 'Mozilla/5.0',
  'Referer': 'https://www.api-football.com',
};

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
    this.fit = BoxFit.contain,
    this.color,
    this.radius = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ///
    /// LOCAL IMAGE
    ///
    if (imageUrl.contains('assets/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          imageUrl,
          height: height,
          width: width,
          fit: fit,
          color: color,
        ),
      );
    }

    ///
    /// VECTOR
    ///
    if (imageUrl.contains('.svg')) {
      return Animate(
        effects: const [
          FadeEffect(
            curve: Curves.easeIn,
            duration: BalunConstants.longAnimationDuration,
          ),
        ],
        child: SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CachedNetworkSVGImage(
              imageUrl,
              height: height,
              width: width,
              fit: fit,
              headers: httpHeaders,
              placeholder: BalunImagePlaceholder(
                height: height,
                width: width,
                color: color,
                radius: radius,
              ),
              errorWidget: BalunImageError(
                height: height,
                width: width,
                radius: radius,
              ),
            ),
          ),
        ),
      );
    }

    ///
    /// MIX LOGOS
    ///
    if (getIt.get<RemoteSettingsService>().value.mixLogos) {
      return Animate(
        effects: const [
          FadeEffect(
            curve: Curves.easeIn,
            duration: BalunConstants.longAnimationDuration,
          ),
        ],
        child: BalunImagePlaceholder(
          height: height,
          width: width,
          color: color,
          animate: false,
          radius: radius,
        ),
      );
    }
    ///
    /// NETWORK IMAGE
    ///
    else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: height,
          width: width,
          fit: fit,
          color: color,
          httpHeaders: httpHeaders,
          placeholder: (context, url) => BalunImagePlaceholder(
            height: height,
            width: width,
            color: color,
            radius: radius,
          ),
          errorWidget: (context, url, error) => BalunImageError(
            height: height,
            width: width,
            radius: radius,
          ),
        ),
      );
    }
  }
}

class BalunImagePlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final bool animate;
  final double radius;

  const BalunImagePlaceholder({
    required this.height,
    required this.width,
    required this.color,
    this.animate = true,
    this.radius = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Animate(
    onPlay: animate
        ? (controller) => controller.loop(
            reverse: true,
            min: 0.6,
          )
        : null,
    effects: animate
        ? const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.shimmerDuration,
            ),
          ]
        : null,
    child: Container(
      padding: const EdgeInsets.all(6),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? getRandomBalunColor(context),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: animate
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: BalunImage(
                imageUrl: BalunIcons.ballNavigation,
                color: context.colors.primaryBackground,
                height: height,
                width: width,
                radius: radius,
              ),
            ),
    ),
  );
}

class BalunImageError extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;

  const BalunImageError({
    required this.height,
    required this.width,
    this.radius = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: width,
    padding: EdgeInsets.all(
      height != null ? height! / 6 : 6,
    ),
    decoration: BoxDecoration(
      color: context.colors.secondaryBackground,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BalunImage(
        imageUrl: BalunIcons.imageError,
        color: context.colors.primaryBackground,
        height: height,
        width: width,
        radius: radius,
      ),
    ),
  );
}
