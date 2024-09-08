import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_it/watch_it.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';
import '../controllers/fixtures_date_controller.dart';

class FixturesDatePicker extends WatchingWidget {
  final DateTime currentDate;

  const FixturesDatePicker({
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    final activeDate = watchIt<FixturesDateController>(
      instanceName: 'fixtures',
    ).value;

    final dates = getIt
        .get<FixturesDateController>(
          instanceName: 'fixtures',
        )
        .dates;

    return SizedBox(
      height: 80,
      child: PageView(
        controller: getIt
            .get<FixturesDateController>(
              instanceName: 'fixtures',
            )
            .controller,
        physics: const BouncingScrollPhysics(),
        children: [
          ///
          /// CHOOSE CUSTOM DATE
          ///
          BalunButton(
            onPressed: () => getIt
                .get<FixturesDateController>(
                  instanceName: 'fixtures',
                )
                .updateDateViaPickerAndRefetch(context),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: !dates.contains(activeDate) ? context.colors.white : context.colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BalunImage(
                      imageUrl: BalunIcons.calendar,
                      height: 20,
                      width: 20,
                      color: !dates.contains(activeDate) ? context.colors.green.withOpacity(0.5) : context.colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('d MMM').format(activeDate).toUpperCase(),
                      style: !dates.contains(activeDate)
                          ? context.textStyles.fixtureDatePickerActive.copyWith(fontSize: 14)
                          : context.textStyles.fixtureDatePickerInactive.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///
          /// DATES
          ///
          ...getIt
              .get<FixturesDateController>(
                instanceName: 'fixtures',
              )
              .dates
              .map(
                (date) => BalunButton(
                  onPressed: () => getIt
                      .get<FixturesDateController>(
                        instanceName: 'fixtures',
                      )
                      .updateDateAndRefetch(date),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: activeDate == date ? context.colors.white : context.colors.green.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            date == currentDate ? 'Today'.toUpperCase() : DateFormat('E').format(date).toUpperCase(),
                            style: activeDate == date ? context.textStyles.fixtureDatePickerActive : context.textStyles.fixtureDatePickerInactive,
                            textAlign: TextAlign.center,
                          ),
                          if (date != currentDate)
                            Text(
                              DateFormat('d MMM').format(date).toUpperCase(),
                              style: activeDate == date
                                  ? context.textStyles.fixtureDatePickerActive.copyWith(fontSize: 14)
                                  : context.textStyles.fixtureDatePickerInactive.copyWith(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),

          ///
          /// CHOOSE CUSTOM DATE
          ///
          BalunButton(
            onPressed: () => getIt
                .get<FixturesDateController>(
                  instanceName: 'fixtures',
                )
                .updateDateViaPickerAndRefetch(context),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: !dates.contains(activeDate) ? context.colors.white : context.colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BalunImage(
                      imageUrl: BalunIcons.calendar,
                      height: 20,
                      width: 20,
                      color: !dates.contains(activeDate) ? context.colors.green.withOpacity(0.5) : context.colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('d MMM').format(activeDate).toUpperCase(),
                      style: !dates.contains(activeDate)
                          ? context.textStyles.fixtureDatePickerActive.copyWith(fontSize: 14)
                          : context.textStyles.fixtureDatePickerInactive.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
