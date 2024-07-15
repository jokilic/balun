import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/fixtures/fixture_response.dart';
import 'match_main_info.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getHeight(),
    );
  }

  void getHeight() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widgetHeightKey.currentContext != null) {
          final renderBox = widgetHeightKey.currentContext?.findRenderObject() as RenderBox?;
          final columnHeight = renderBox?.size.height;

          if (columnHeight != null) {
            setState(
              () => panelHeight = columnHeight,
            );
          }
        }
      },
    );
  }

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
            minHeight: panelHeight,
            maxHeight: MediaQuery.sizeOf(context).height,
            panelBuilder: () => Container(
              color: Colors.green,
              child: const Text('hello there'),
            ),
          ),
        ],
      );
}
