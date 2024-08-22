import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';

class FixturesDatePicker extends StatefulWidget {
  final DateTime now;

  const FixturesDatePicker({
    required this.now,
  });

  @override
  State<FixturesDatePicker> createState() => _FixturesDatePickerState();
}

class _FixturesDatePickerState extends State<FixturesDatePicker> {
  late final CarouselController controller;

  @override
  void initState() {
    super.initState();
    controller = CarouselController(initialItem: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 80,
        child: PageView(
          // controller: controller,
          // elevation: 0,
          // onTap: (value) => getIt
          //     .get<FixturesDateController>(
          //       instanceName: 'fixtures',
          //     )
          //     .updateDate(value),
          // overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          // itemSnapping: true,
          // padding: EdgeInsets.zero,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(8),
          // ),
          // backgroundColor: Colors.transparent,
          // itemExtent: 144,
          children: List.generate(
            7,
            (index) {
              final date = widget.now.add(Duration(days: index - 3));

              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: index == 3 ? context.colors.white : context.colors.green.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    DateFormat('d MMM').format(date).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: index == 3 ? context.colors.green.withOpacity(0.5) : context.colors.white,
                      fontSize: 16,
                      fontWeight: index == 3 ? FontWeight.bold : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
}
