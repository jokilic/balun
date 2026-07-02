import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/balun_image.dart';

class FixturesListTileLogo extends StatelessWidget {
  final String logo;
  final bool hasProperLogo;

  const FixturesListTileLogo({
    required this.logo,
    required this.hasProperLogo,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: context.colors.accent,
      shape: BoxShape.circle,
    ),
    height: 58,
    width: 58,
    padding: const EdgeInsets.all(8),
    child: BalunImage(
      imageUrl: logo,
      color: !hasProperLogo ? context.colors.primaryForeground : null,
    ),
  );
}
