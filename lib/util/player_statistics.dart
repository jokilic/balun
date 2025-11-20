import 'package:flutter/material.dart';

import '../theme/theme.dart';

Color? getRatingColor(double rating, {required BuildContext context}) {
  switch (rating) {
    case >= 9.0:
      return context.colors.info;
    case < 9.0 && >= 7.0:
      return context.colors.success;
    case < 7.0 && >= 6.5:
      return context.colors.warning;
    case < 6.5 && >= 5.5:
      return context.colors.alert;
    case < 5.5:
      return context.colors.danger;
    default:
      return context.colors.info;
  }
}
