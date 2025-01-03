import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/balun_image.dart';

class FixturesListTileLogo extends StatelessWidget {
  final String logo;

  const FixturesListTileLogo({
    required this.logo,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.greenish.withValues(alpha: 0.5),
        ),
        padding: const EdgeInsets.all(8),
        child: BalunImage(
          imageUrl: logo,
        ),
      );
}
