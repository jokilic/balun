import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/theme.dart';

class BalunLoader extends StatelessWidget {
  final Color? color;

  const BalunLoader({
    this.color,
  });

  @override
  Widget build(BuildContext context) => SpinKitWanderingCubes(
        color: color ?? context.colors.white,
        size: 40,
      );
}
