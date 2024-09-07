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
          color: context.colors.greenish.withOpacity(0.5),
        ),
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BalunImage(
            imageUrl: logo,
          ),
        ),
      );
}
