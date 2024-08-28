import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_it/watch_it.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/custom_page_scroll_physics.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/balun_button.dart';
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

    return SizedBox(
      height: 80,
      child: PageView(
        controller: getIt
            .get<FixturesDateController>(
              instanceName: 'fixtures',
            )
            .controller,
        physics: const CustomPageScrollPhysics(
          viewportFraction: 0.4,
        ),
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
                color: context.colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image.asset(
                  BalunIcons.calendar,
                  height: 28,
                  width: 28,
                  color: context.colors.white,
                ),
              ),
            ),
          ),

          ///
          /// DATES
          ///
          ...List.generate(
            7,
            (index) {
              final date = currentDate.add(
                Duration(
                  days: index -
                      getIt
                          .get<FixturesDateController>(
                            instanceName: 'fixtures',
                          )
                          .initialPage,
                ),
              );

              return BalunButton(
                onPressed: () => getIt
                    .get<FixturesDateController>(
                      instanceName: 'fixtures',
                    )
                    .updateDateAndRefetch(index),
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
              );
            },
          ),

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
                color: context.colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image.asset(
                  BalunIcons.calendar,
                  height: 32,
                  width: 32,
                  color: context.colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
