import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';

import 'balun_image.dart';

class BalunImageSVG extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;

  const BalunImageSVG({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CachedNetworkSVGImage(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: BalunImagePlaceholder(
          height: height,
          width: width,
          color: color,
        ),
        errorWidget: BalunImageError(
          height: height,
          width: width,
        ),
      );
}
