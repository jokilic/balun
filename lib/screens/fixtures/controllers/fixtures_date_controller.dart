import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../services/logger_service.dart';

class FixturesDateController extends ValueNotifier<DateTime> {
  final DateTime now;
  final LoggerService logger;

  FixturesDateController({
    required this.now,
    required this.logger,
  }) : super(now);

  ///
  /// METHODS
  ///

  void updateDate(int value) {
    final date = now.add(Duration(days: value - 3));
    log('Pressed -> ${date.toIso8601String()}');
  }
}
