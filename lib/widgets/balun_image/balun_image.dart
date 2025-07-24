import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants.dart';
import '../../services/remote_settings_service.dart';
import '../../theme/icons.dart';
import '../../theme/theme.dart';
import '../../util/color.dart';
import '../../util/dependencies.dart';
import 'balun_image_svg_stub.dart';

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
      if (kIsWeb) {
        return ExtendedImage.asset(
          imageUrl,
          height: height,
          width: width,
          fit: fit,
          color: color,
          loadStateChanged: (state) => Animate(
            key: ValueKey(state.extendedImageLoadState),
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: BalunConstants.longAnimationDuration,
              ),
            ],
            child: switch (state.extendedImageLoadState) {
              LoadState.completed => state.completedWidget,
              LoadState.loading => BalunImagePlaceholder(
                height: height,
                width: width,
                color: color,
                radius: radius,
              ),
              LoadState.failed => BalunImageError(
                height: height,
                width: width,
                radius: radius,
              ),
            },
          ),
        );
      } else {
        return Image.asset(
          imageUrl,
          height: height,
          width: width,
          fit: fit,
          color: color,
        );
      }
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
          child: BalunImageSVG(
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: fit,
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
      if (kIsWeb) {
        return ExtendedImage.network(
          imageUrl,
          height: height,
          width: width,
          fit: fit,
          color: color,
          loadStateChanged: (state) => Animate(
            key: ValueKey(state.extendedImageLoadState),
            effects: const [
              FadeEffect(
                curve: Curves.easeIn,
                duration: BalunConstants.longAnimationDuration,
              ),
            ],
            child: switch (state.extendedImageLoadState) {
              LoadState.completed => state.completedWidget,
              LoadState.loading => BalunImagePlaceholder(
                height: height,
                width: width,
                color: color,
                radius: radius,
              ),
              LoadState.failed => BalunImageError(
                height: height,
                width: width,
                radius: radius,
              ),
            },
          ),
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl,
          height: height,
          width: width,
          fit: fit,
          color: color,
          placeholder: (context, url) => BalunImagePlaceholder(
            height: height,
            width: width,
            color: color,
          ),
          errorWidget: (context, url, error) => BalunImageError(
            height: height,
            width: width,
          ),
        );
      }
    }
  }
}

class BalunImagePlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final bool animate;
  final double radius;

  const BalunImagePlaceholder({
    required this.height,
    required this.width,
    required this.color,
    this.fit = BoxFit.cover,
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
        borderRadius: BorderRadius.circular(radius),
        color: color ?? getRandomBalunColor(context),
      ),
      child: animate
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: BalunImage(
                imageUrl: BalunIcons.ballNavigation,
                color: context.colors.primaryForeground,
                height: height,
                width: width,
                fit: fit,
                radius: radius,
              ),
            ),
    ),
  );
}

class BalunImageError extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit fit;
  final double radius;

  const BalunImageError({
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
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
      border: Border.all(
        color: context.colors.danger,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
