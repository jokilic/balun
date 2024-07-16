import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/match_section.dart';
import 'sections/match_events_section.dart';
import 'sections/match_formations_section.dart';
import 'sections/match_head_to_head_section.dart';
import 'sections/match_info_section.dart';
import 'sections/match_injuries_section.dart';
import 'sections/match_league_section.dart';
import 'sections/match_lineups_section.dart';
import 'sections/match_statistics_section.dart';

class MatchActiveSection extends StatelessWidget {
  final MatchSection matchSection;

  const MatchActiveSection({
    required this.matchSection,
  });

  @override
  Widget build(BuildContext context) => switch (matchSection) {
        MatchSection(
          matchSectionEnum: MatchSectionEnum.info,
        ) =>
          MatchInfoSection(),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.league,
        ) =>
          MatchLeagueSection(),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.events,
        ) =>
          MatchEventsSection(),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.lineups,
        ) =>
          MatchLineupsSection(),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.formations,
        ) =>
          MatchFormationsSection(),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.headToHead,
        ) =>
          MatchHeadToHeadSection(),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.statistics,
        ) =>
          MatchStatisticsSection(),
        MatchSection(
          matchSectionEnum: MatchSectionEnum.injuries,
        ) =>
          MatchInjuriesSection(),
      };
}
