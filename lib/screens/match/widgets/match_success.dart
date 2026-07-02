import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../theme/theme.dart';
import '../../../util/date_time.dart';
import '../../../util/dependencies.dart';
import '../../../util/string.dart';
import '../../../widgets/widget_size.dart';
import '../controllers/match_section_controller.dart';
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

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getIt
          .get<MatchSectionController>(
            instanceName: '${widget.match.fixture?.id}',
          )
          .updateStateDependingOnMatchStatus(
            statusShort: widget.match.fixture?.status?.short ?? '--',
            lineupExists: widget.match.lineups?.isNotEmpty ?? false,
            eventsExist: widget.match.events?.isNotEmpty ?? false,
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

    final matchText = getFixtureListTileText(
      statusShort: widget.match.fixture?.status?.short ?? '--',
      timestamp: widget.match.fixture?.timestamp,
      homeGoalsRegular: widget.match.score?.fulltime?.home ?? widget.match.goals?.home,
      awayGoalsRegular: widget.match.score?.fulltime?.away ?? widget.match.goals?.away,
      homeGoalsExtraTime: widget.match.score?.extratime?.home,
      awayGoalsExtraTime: widget.match.score?.extratime?.away,
      homeGoalsPenalties: widget.match.score?.penalty?.home,
      awayGoalsPenalties: widget.match.score?.penalty?.away,
      languageTag: context.locale.toLanguageTag(),
    );

    return Stack(
      children: [
        ///
        /// TOP CONTENT
        ///
        WidgetSize(
          onChange: (size) => setState(
            () => panelHeight = (screenHeight - size.height) - 80,
          ),
          child: MatchMainInfo(
            match: widget.match,
            homeScoreRegular: matchText.homeScoreRegular,
            awayScoreRegular: matchText.awayScoreRegular,
            homeScoreExtraTime: matchText.homeScoreExtraTime,
            awayScoreExtraTime: matchText.awayScoreExtraTime,
            homeScorePenalties: matchText.homeScorePenalties,
            awayScorePenalties: matchText.awayScorePenalties,
            matchPlaying: isMatchPlaying(
              statusShort: widget.match.fixture?.status?.short ?? '--',
            ),
            matchFinishedExtraTime: matchText.isFinishedExtraTime ?? false,
            matchFinishedPenalties: matchText.isFinishedPenalties ?? false,
            isHomeWinner: widget.match.teams?.home?.winner ?? false,
            isAwayWinner: widget.match.teams?.away?.winner ?? false,
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
          panelBuilder: () => MatchSlidingInfo(
            match: widget.match,
            scrollController: scrollController,
            season: widget.match.league?.season ?? getCurrentSeasonYear().toString(),
          ),
        ),
      ],
    );
  }
}
