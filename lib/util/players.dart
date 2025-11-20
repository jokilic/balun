import 'package:flutter/material.dart';

import '../theme/theme.dart';

Color? getPositionColor(String position, {required BuildContext context}) => switch (position.toLowerCase()) {
  'goalkeeper' => context.colors.alert,
  'defender' => context.colors.info,
  'midfielder' => context.colors.success,
  'attacker' => context.colors.danger,
  _ => context.colors.primaryForeground,
};

String? getPositionText(String position) => position.substring(0, 1).toUpperCase();
