import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/teams/team_response.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widget_size.dart';
import 'main_info/team_main_info.dart';
import 'sliding_info/team_sliding_info.dart';

class TeamSuccess extends StatefulWidget {
  final TeamResponse team;
  final int season;

  const TeamSuccess({
    required this.team,
    required this.season,
  });

  @override
  State<TeamSuccess> createState() => _TeamSuccessState();
}

class _TeamSuccessState extends State<TeamSuccess> {
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
            child: TeamMainInfo(
              team: widget.team,
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
            panelBuilder: () => TeamSlidingInfo(
              team: widget.team,
              scrollController: scrollController,
              season: widget.season,
            ),
          ),
        ],
      );
}
