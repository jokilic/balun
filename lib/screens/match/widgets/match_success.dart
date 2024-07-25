import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../theme/theme.dart';
import 'main_info/match_main_info.dart';
import 'sliding_info/match_sliding_info.dart';

class MatchSuccess extends StatefulWidget {
  final FixtureResponse match;

  const MatchSuccess({
    required this.match,
  });

  @override
  State<MatchSuccess> createState() => _MatchSuccessState();
}

class _MatchSuccessState extends State<MatchSuccess> {
  final widgetHeightKey = GlobalKey();
  late var panelHeight = 100.0;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getHeight(),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void getHeight() => WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (widgetHeightKey.currentContext != null) {
            final renderBox = widgetHeightKey.currentContext?.findRenderObject() as RenderBox?;
            final columnHeight = renderBox?.size.height;

            if (columnHeight != null) {
              setState(() => panelHeight = columnHeight);
            }
          }
        },
      );

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          ///
          /// TOP CONTENT
          ///
          MatchMainInfo(
            match: widget.match,
            widgetHeightKey: widgetHeightKey,
          ),

          ///
          /// SLIDING CONTENT
          ///
          SlidingUpPanel(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            color: context.colors.white,
            scrollController: scrollController,
            minHeight: panelHeight,
            maxHeight: MediaQuery.sizeOf(context).height - 144,
            panelBuilder: () => MatchSlidingInfo(
              match: widget.match,
              scrollController: scrollController,
            ),
          ),
        ],
      );
}
