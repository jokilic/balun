import 'dart:async';
import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../services/logger_service.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/date_time.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';
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
  late final dates = List.generate(
    7,
    (index) => currentDate.add(
      Duration(
        days:
            index -
            getIt
                .get<FixturesDateController>(
                  instanceName: 'fixtures',
                )
                .initialPage,
      ),
    ),
  );

  ///
  /// METHODS
  ///

  void updateDateAndRefetch(DateTime newDate) {
    final oldValue = value;

    value = newDate;

    if (oldValue != value) {
      getIt
          .get<FixturesController>(
            instanceName: 'fixtures',
          )
          .getFixturesFromDate(
            dateString: getDateForBackend(value),
          );
    }
  }

  Future<void> updateDateViaPickerAndRefetch(BuildContext context) async => showCalendarDatePicker2Dialog(
    context: context,
    onValueChanged: (newValue) async {
      final chosenDate = newValue.first;

      if (chosenDate != null && value != chosenDate) {
        Navigator.of(context).pop();

        value = chosenDate;

        await getIt
            .get<FixturesController>(
              instanceName: 'fixtures',
            )
            .getFixturesFromDate(
              dateString: getDateForBackend(chosenDate),
            );
      }
    },
    config: CalendarDatePicker2WithActionButtonsConfig(
      weekdayLabelTextStyle: context.textStyles.bodyMdBold,
      controlsTextStyle: context.textStyles.bodyMdBold,
      dayTextStyle: context.textStyles.bodyMd,
      todayTextStyle: context.textStyles.bodyLgBold,
      selectedDayTextStyle: context.textStyles.bodyLgBold.copyWith(
        color: context.colors.primaryBackground,
      ),
      selectedMonthTextStyle: context.textStyles.bodyLgBold.copyWith(
        color: context.colors.primaryBackground,
      ),
      selectedYearTextStyle: context.textStyles.bodyLgBold.copyWith(
        color: context.colors.primaryBackground,
      ),
      selectedDayHighlightColor: context.colors.accentStrong,
      daySplashColor: context.colors.accentStrong,
      firstDayOfWeek: 1,
      useAbbrLabelForMonthModePicker: true,
      cancelButton: BalunButton(
        child: Text(
          'fixturesCalendarCancel'.tr().toUpperCase(),
          style: context.textStyles.bodyMd,
        ),
      ),
      okButton: BalunButton(
        child: Text(
          'fixturesCalendarGo'.tr().toUpperCase(),
          style: context.textStyles.bodyMdBold,
        ),
      ),
      lastMonthIcon: BalunImage(
        imageUrl: BalunIcons.back,
        height: 20,
        width: 20,
        color: context.colors.primaryForeground,
      ),
      nextMonthIcon: Transform.rotate(
        angle: pi,
        child: BalunImage(
          imageUrl: BalunIcons.back,
          height: 20,
          width: 20,
          color: context.colors.primaryForeground,
        ),
      ),
    ),
    borderRadius: BorderRadius.circular(8),
    dialogBackgroundColor: context.colors.accentLight,
    dialogSize: const Size(325, 400),
  );
}
