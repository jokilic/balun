// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class BalunSeperator extends StatelessWidget {
  final double verticalSpace;

  const BalunSeperator({
    this.verticalSpace = 4,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(
          vertical: verticalSpace,
        ),
        height: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: context.colors.greenish,
        ),
      );
}
