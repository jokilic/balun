import 'package:flutter/material.dart';

import '../theme/theme.dart';

class BalunSeperator extends StatelessWidget {
  final double verticalSpace;
  final Color? color;

  const BalunSeperator({
    this.verticalSpace = 4,
    this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      vertical: verticalSpace,
    ),
    height: 1,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: color ?? context.colors.accentLight,
    ),
  );
}
