import 'package:flutter/material.dart';

import 'logger_service.dart';

class LeagueStorageService extends ValueNotifier<List<int>> {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;

  LeagueStorageService({
    required this.logger,
  }) : super([]);

  ///
  /// METHODS
  ///

  Future<void> init() async {}
}
