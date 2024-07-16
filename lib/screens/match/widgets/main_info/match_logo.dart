import 'package:flutter/material.dart';

import '../../../../widgets/balun_image.dart';

class MatchLogo extends StatelessWidget {
  final String logo;

  const MatchLogo({
    required this.logo,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BalunImage(
          imageUrl: logo,
          height: 80,
          width: 80,
        ),
      );
}
