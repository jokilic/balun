import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import 'fixtures_controller.dart';

class FixturesDateController extends ValueNotifier<DateTime> implements Disposable {
  final DateTime currentDate;
  final LoggerService logger;

  FixturesDateController({
    required this.currentDate,
    required this.logger,
  }) : super(currentDate) {
    const viewportFraction = 0.4;

    controller = PageController(
      initialPage: initialPage,
      viewportFraction: viewportFraction,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final pageOffset = initialPage * viewportFraction;
        const centeringOffset = (1 - viewportFraction) / 2;

        controller
            .animateToPage(
              initialPage,
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
            )
            .then(
              (_) => controller.animateTo(
                (pageOffset + centeringOffset) * controller.position.viewportDimension,
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
              ),
            );
      },
    );
  }

  @override
  FutureOr onDispose() {
    controller.dispose();
  }

  ///
  /// VARIABLES
  ///

  final initialPage = 3;
  late final PageController controller;

  ///
  /// METHODS
  ///

  String getDateForBackend() {
    final year = value.year.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  void updateDateAndRefetch(int index) {
    final oldValue = value;

    value = currentDate.add(
      Duration(
        days: index - initialPage,
      ),
    );

    if (oldValue != value) {
      getIt
          .get<FixturesController>(
            instanceName: 'fixtures',
          )
          .getFixturesFromDate(
            dateString: getDateForBackend(),
          );
    }
  }

  Future<void> updateDateViaPickerAndRefetch(BuildContext context) async {
    final oldValue = value;

    // TODO: Update date picker
    value = await showDatePicker(
          context: context,
          firstDate: DateTime(2010),
          lastDate: currentDate.add(
            const Duration(days: 2 * 365),
          ),
        ) ??
        value;

    if (oldValue != value) {
      await getIt
          .get<FixturesController>(
            instanceName: 'fixtures',
          )
          .getFixturesFromDate(
            dateString: getDateForBackend(),
          );
    }
  }
}
