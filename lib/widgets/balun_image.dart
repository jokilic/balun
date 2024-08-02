import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BalunImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const BalunImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) => imageUrl.contains('assets/')
      ? Image.asset(
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
          placeholder: (_, __) => loadingWidget ?? const SizedBox.shrink(),
          errorWidget: (_, __, ___) => errorWidget ?? const SizedBox.shrink(),
        );
}
