import 'package:flutter/material.dart';

import '../theme/theme.dart';

class BalunLoader extends StatelessWidget {
  final Color? color;

  const BalunLoader({
    this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? context.colors.white,
        ),
        height: 40,
        width: 40,
      );
}
