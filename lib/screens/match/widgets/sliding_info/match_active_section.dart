import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/fixtures/fixture_response.dart';
import '../../../../models/match_section.dart';
import '../../../../util/events.dart';
import 'sections/events/match_events_section.dart';
import 'sections/lineups/match_lineups_section.dart';
import 'sections/match_formations_section.dart';
import 'sections/match_head_to_head_section.dart';
import 'sections/match_info_section.dart';
import 'sections/match_injuries_section.dart';
import 'sections/match_statistics_section.dart';
import 'sections/standings/match_standings_section.dart';

class MatchActiveSection extends StatelessWidget {
  final FixtureResponse match;
  final MatchSection matchSection;

  const MatchActiveSection({
    required this.match,
    required this.matchSection,
  });

  @override
  Widget build(BuildContext context) => switch (matchSection) {
        MatchSection(matchSectionEnum: MatchSectionEnum.info) => MatchInfoSection(
            timestamp: match.fixture?.timestamp,
            referee: match.fixture?.referee,
            venue: match.fixture?.venue,
            status: match.fixture?.status,
            league: match.league,
          ),
        MatchSection(matchSectionEnum: MatchSectionEnum.standings) => MatchStandingsSection(
            leagueId: match.league?.id,
            season: match.league?.season,
          ),
        MatchSection(matchSectionEnum: MatchSectionEnum.events) => MatchEventsSection(
            eventsScoresList: getEventsList(
              events: match.events,
              score: match.score,
            ),
            awayTeamId: match.teams?.away?.id,
          ),
        MatchSection(matchSectionEnum: MatchSectionEnum.lineups) => MatchLineupsSection(
            lineups: match.lineups,
          ),
        MatchSection(matchSectionEnum: MatchSectionEnum.formations) => MatchFormationsSection(),
        MatchSection(matchSectionEnum: MatchSectionEnum.headToHead) => MatchHeadToHeadSection(),
        MatchSection(matchSectionEnum: MatchSectionEnum.statistics) => MatchStatisticsSection(),
        MatchSection(matchSectionEnum: MatchSectionEnum.injuries) => MatchInjuriesSection(),
      };
}
