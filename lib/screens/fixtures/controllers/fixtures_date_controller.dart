import 'dart:async';
import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../services/logger_service.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
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
        days: index -
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

  String getDateForBackend() {
    final year = value.year.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  void updateDateAndRefetch(DateTime newDate) {
    final oldValue = value;

    value = newDate;

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
    final newValue = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        weekdayLabelTextStyle: context.textStyles.teamTransferTeam,
        controlsTextStyle: context.textStyles.teamTransferTeam,
        dayTextStyle: context.textStyles.calendarDayInactive,
        todayTextStyle: context.textStyles.calendarDayActive,
        selectedDayTextStyle: context.textStyles.calendarDayActive.copyWith(
          color: context.colors.white,
        ),
        selectedMonthTextStyle: context.textStyles.calendarDayActive.copyWith(
          color: context.colors.white,
        ),
        selectedYearTextStyle: context.textStyles.calendarDayActive.copyWith(
          color: context.colors.white,
        ),
        selectedDayHighlightColor: context.colors.green,
        daySplashColor: context.colors.green,
        firstDayOfWeek: 1,
        useAbbrLabelForMonthModePicker: true,
        cancelButton: BalunButton(
          child: Text(
            'Cancel'.toUpperCase(),
            style: context.textStyles.calendarDayInactive,
          ),
        ),
        okButton: BalunButton(
          child: Text(
            'Go'.toUpperCase(),
            style: context.textStyles.teamTransferTeam,
          ),
        ),
        lastMonthIcon: const BalunImage(
          imageUrl: BalunIcons.back,
          height: 20,
          width: 20,
        ),
        nextMonthIcon: Transform.rotate(
          angle: pi,
          child: const BalunImage(
            imageUrl: BalunIcons.back,
            height: 20,
            width: 20,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(16),
      dialogBackgroundColor: context.colors.greenish,
      dialogSize: const Size(325, 400),
    );

    if (newValue != null && value != newValue.first) {
      value = newValue.first!;

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
