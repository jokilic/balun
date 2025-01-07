import 'package:extended_image/extended_image.dart';
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

  const BalunImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ///
    /// LOCAL IMAGE
    ///
    if (imageUrl.contains('assets/')) {
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
              ),
            LoadState.failed => BalunImageError(
                height: height,
                width: width,
              ),
          },
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
        ),
      );
    }

    ///
    /// NETWORK IMAGE
    ///
    else {
      return ExtendedImage.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
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
              ),
            LoadState.failed => BalunImageError(
                height: height,
                width: width,
              ),
          },
        ),
      );
    }
  }
}

class BalunImagePlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final bool animate;

  const BalunImagePlaceholder({
    required this.height,
    required this.width,
    required this.color,
    this.fit = BoxFit.cover,
    this.animate = true,
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
            borderRadius: BorderRadius.circular(100),
            color: color ?? getRandomBalunColor(context),
          ),
          child: animate
              ? null
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BalunImage(
                    imageUrl: BalunIcons.ballNavigation,
                    color: context.colors.black,
                    height: height,
                    width: width,
                    fit: fit,
                  ),
                ),
        ),
      );
}

class BalunImageError extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit fit;

  const BalunImageError({
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
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
            color: context.colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BalunImage(
            imageUrl: BalunIcons.ballNavigation,
            color: context.colors.red,
            height: height,
            width: width,
            fit: fit,
          ),
        ),
      );
}
