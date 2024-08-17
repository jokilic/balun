import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widget_size.dart';
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
  Widget build(BuildContext context) => Stack(
        children: [
          ///
          /// TOP CONTENT
          ///
          WidgetSize(
            onChange: (size) => setState(
              () => panelHeight = (MediaQuery.sizeOf(context).height - size.height) - 80,
            ),
            child: MatchMainInfo(
              match: widget.match,
            ),
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
              season: widget.match.league?.season ?? DateTime.now().year,
            ),
          ),
        ],
      );
}
