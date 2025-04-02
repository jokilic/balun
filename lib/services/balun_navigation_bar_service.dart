import 'package:flutter/material.dart';

import '../util/dependencies.dart';
import 'balun_screen_service.dart';
import 'logger_service.dart';

enum BalunNavigationBarEnum {
  fixtures,
  countries,
  search,
  settings,
}

class BalunNavigationBarService extends ValueNotifier<BalunNavigationBarEnum> {
  final LoggerService logger;

  BalunNavigationBarService({
    required this.logger,
  }) : super(BalunNavigationBarEnum.fixtures);

  ///
  /// METHODS
  ///

  void changeNavigationBarIndex(BalunNavigationBarEnum newNavigationValue) {
    value = newNavigationValue;
    getIt.get<BalunScreenService>().changeScreen(newNavigationValue);
  }
}
