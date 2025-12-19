import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/leagues/league_response.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/widget_size.dart';
import '../controllers/league_season_controller.dart';
import 'main_info/league_main_info.dart';
import 'sliding_info/league_sliding_info.dart';

class LeagueSuccess extends StatefulWidget {
  final LeagueResponse league;

  const LeagueSuccess({
    required this.league,
  });

  @override
  State<LeagueSuccess> createState() => _LeagueSuccessState();
}

class _LeagueSuccessState extends State<LeagueSuccess> {
  late var panelHeight = 100.0;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getIt
          .get<LeagueSeasonController>(
            instanceName: '${widget.league.league?.id}',
          )
          .scrollToInitialSeason(
            seasonsYears: widget.league.seasons?.map((season) => season.year.toString()).toList(),
          ),
    );
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
          child: LeagueMainInfo(
            league: widget.league,
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
          panelBuilder: () => LeagueSlidingInfo(
            league: widget.league,
            scrollController: scrollController,
          ),
        ),
      ],
    );
  }
}
