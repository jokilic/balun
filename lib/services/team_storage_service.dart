import 'package:flutter/material.dart';

import 'logger_service.dart';

class TeamStorageService extends ValueNotifier<List<int>> {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;

  TeamStorageService({
    required this.logger,
  }) : super([]);

  ///
  /// METHODS
  ///

  Future<void> init() async {}
}
