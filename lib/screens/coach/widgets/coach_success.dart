import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/coaches/coach_response.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widget_size.dart';
import 'main_info/coach_main_info.dart';
import 'sliding_info/coach_sliding_info.dart';

class CoachSuccess extends StatefulWidget {
  final CoachResponse coach;

  const CoachSuccess({
    required this.coach,
  });

  @override
  State<CoachSuccess> createState() => _CoachSuccessState();
}

class _CoachSuccessState extends State<CoachSuccess> {
  late var panelHeight = 100.0;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        ///
        /// TOP CONTENT
        ///
        WidgetSize(
          onChange: (size) => setState(
            () => panelHeight = (screenHeight - size.height) - 80,
          ),
          child: CoachMainInfo(
            coach: widget.coach,
          ),
        ),

        ///
        /// SLIDING CONTENT
        ///
        SlidingUpPanel(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40),
          ),
          color: context.colors.slidingInfoPanelBackground,
          scrollController: scrollController,
          minHeight: panelHeight,
          maxHeight: screenHeight - 144,
          panelBuilder: () => CoachSlidingInfo(
            coach: widget.coach,
            scrollController: scrollController,
          ),
        ),
      ],
    );
  }
}
