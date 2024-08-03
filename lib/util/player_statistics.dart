import 'package:flutter/material.dart';

import '../theme/theme.dart';

// TODO: Pick better colors
Color? getRatingColor(double rating, {required BuildContext context}) {
  switch (rating) {
    case >= 7.0:
      return context.colors.green;
    case < 7.0 && >= 6.5:
      return context.colors.yellow;
    case < 6.5 && >= 5.5:
      return context.colors.orange;
    case < 5.5:
      return context.colors.red;
    default:
      return context.colors.blue;
  }
}
