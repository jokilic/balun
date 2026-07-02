import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/balun_image.dart';

class MatchLogo extends StatelessWidget {
  final String logo;

  const MatchLogo({
    required this.logo,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: context.colors.primaryBackgroundLight,
      shape: BoxShape.circle,
    ),
    height: 88,
    width: 88,
    padding: const EdgeInsets.all(12),
    child: BalunImage(
      imageUrl: logo,
    ),
  );
}
