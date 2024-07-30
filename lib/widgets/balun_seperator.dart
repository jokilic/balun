import 'package:flutter/material.dart';

import '../theme/theme.dart';

class BalunSeperator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: context.colors.greenish,
        ),
      );
}
